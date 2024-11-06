terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

# Random string used added to the name of sa_01 to make a valid name
# resource "random_string" "random_string" {
#   length  = 20
#   special = false
# }

# resource "azurerm_service_plan" "service_plan_01" {
#   name                = var.service_plan_name
#   location            = var.location
#   resource_group_name = var.rg_name
#   os_type             = "Linux"
#   sku_name            = "P1v2"
# }

# resource "azurerm_linux_web_app" "web_app" {
#   name                = "${var.app_service_name}${random_string.random_string.result}"
#   location            = var.location
#   resource_group_name = var.rg_name
#   service_plan_id     = azurerm_service_plan.service_plan_01.id

#   site_config {
#   }
#   app_settings = {
#     WEBSITE_RUN_FROM_PACKAGE = "https://${var.sa_name}.blob.core.windows.net/${var.sc_name}/${var.sb_index_name}"
#   }

#   storage_account {
#     name         = "sa_01"
#     account_name = var.sa_name
#     share_name   = var.sc_name
#     access_key   = var.sa_access_key
#     type         = "AzureBlob"
#   }

#   connection_string {
#     name  = "Database"
#     type  = "SQLAzure"
#     value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
#   }
# }

resource "azurerm_public_ip" "lb_public_ip" {
  name                = "lbPublicIP"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "load_balancer" {
  name                = "myLoadBalancer"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

resource "azurerm_network_interface" "proxy_nic" {
  name                = "proxyNic"
  location            = var.location
  resource_group_name = var.rg_name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
  name            = "BackendPool"
  loadbalancer_id = azurerm_lb.load_balancer.id
}

resource "azurerm_lb_probe" "http_probe" {

  loadbalancer_id     = azurerm_lb.load_balancer.id
  name                = "httpProbe"
  protocol            = "Http"
  port                = 80
  request_path        = "/"
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_linux_virtual_machine" "web_vm" {
  name                  = "webserver-vm"
  location              = var.location
  resource_group_name   = var.rg_name
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  size                  = "Standard_B1s"

  admin_username = "adminuser"
  admin_password = "YourPassword1234!" # Alternatively, use SSH keys

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io docker-compose git",
      "sudo usermod -aG docker ${self.admin_username}", # Add user to Docker group
    ]
  }
}

resource "azurerm_virtual_machine_extension" "web_vm_extension" {
  name                 = "webserver-setup"
  virtual_machine_id   = azurerm_linux_virtual_machine.web_vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"
  settings             = <<SETTINGS
    {
      "commandToExecute": "git clone https://gitlab.stud.idi.ntnu.no/ulrikof/fridge-friend-mirror.git /home/${azurerm_linux_virtual_machine.web_vm.admin_username}/app && cd /home/${azurerm_linux_virtual_machine.web_vm.admin_username}/app && sudo docker-compose up -d"
    }
  SETTINGS
}