output "lb_id" {
  value = azurerm_lb.lb_01.id
}

output "lb_public_ip" {
  value = azurerm_public_ip.public_ip_01.ip_address
}