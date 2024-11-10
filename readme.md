# CI/CD

I have created a fully working CI/CD system with github workflows.

## CI

To do this i have created to CI workflows: terraform_lint.yml and tfsec.yml. Both of these workflows are callable, meaning that other workflows can call them before running. This is crucial to ensure a fully working CI/CD system.

### tfsec

This workflow runs tfsec, a program that automatically checks for security vulnarabilities in my terraform code. I have set it up to only fail upon critical errors. This is since this assigment is mostly meant for testing, and not creating a super secure enviroment, and i therefore did not see the point in fixing every small potential security problem.

### terraform lint

This workflows runs terraform format check on all files, which wil fail if it discoveres some bad formatting. It also runs terraform validate to catch syntax error in my code. This helps catching potential errors before they are applied to the actuall infrastructure.

## CD

Here i have the developed two types of workflows.

### deploy_main_infra & destroy_main_infra

These workflows work pretty normally.

The deploy_main_infra runs on each merge into main. Here i first call the terraform lint and tfsec workflows to ensure that the code is permittable. Then i update my global resources. When this is finished i update my dev enviorment, and then the staging enviorment and lastly the prod enviorment. Since i only have one set of configuration files, i use workspaces to create a different state file for each enviorment. I also use the workspace name to give a unique name to the root resource group where all the other resources are placed, which makes it clear what resource group belongs to what enviorment. I also deploy the resources in each enviorment with its corresponding tfvars file to ensure all the resources have the correct settings. I also have a enviorment call in the stage where i deploy to prod. This is, however, commented out to avoid having to make my repo public.

The destroy_main_infra is a manually callable workflow that deletes all the resources in all the enviorments. This is mostly needed since we dont want waste money on having our resources running continually.

### deploy_branch_infra & destroy_branch_infra

These workflows are what i have used the most time on. They are pretty unique as far as i know, and was created sine it was something i thought could be usefull.

The generall concept here is that when someone commits something to a branch, the deploy_branch_infra workflow automatically creates a workspace with the same name as the branch with a "dev-" prefix, and then deploys the infrastructure in deployment in this workspace. This has some major benifits. Firstly, it ensures a single source of truth on an even deeper level. This is since we are now sure that the state of development infra from a branch is the excact same as the code in the branch, and not some local files somewhere. This also means that one newer needs to run "terraform init" and terrafrom apply locally, as this is automatically done. Secondly, it ensures a predictable way of working in different branches at the same time. When doing this locally, one can for instance deploy infrastructure in the same workspace, and this could cause issues. Lastly, since we can call the tfsec and terraform lint workflows before we run this one, we lower the chances of errors in deployment caused by simple errors. The one downside to this is that it can become rather expensive if one has a very large infrastructure and a lot of active branches. This is especially the branches have a long lifespan.

The destroy_branch_infra is called when a branch is merged into main, and then destroy the infrastructure related to this branch. This gives the branch infrastructure a very nice lifecycle where it is updated on each commit, and when we are satisfied with the changes in the branch, it is then in a way pulled into the main infrastructure and replaces this. This gives a very predictable way of working with infrastructure in branches, and i have felt that is has worked very well for me during this assignment.

# Modules

My solution consists of five separate modules that each contain necessary resources for these tasks. These are all called by the main.tf file in the deployments folder. The five modules works as follows:

## Linux service plan module

This consists of a single service plan resource. It needs three variables as default, the name of the resource group the service plan should be placed, the location of the resource, and its name. It also takes a sku value as a variable, and this is intended for having a different sku in different enviorments. It outputs its ID for a potential integration with an app service or web app resource.

## Load balancer module

This consists of a public ip resource that is used by a load balancer resource. It takes the name of the public ip, the name of the load balancer and the location and resource group where the resources should be placed as variables. It outputs the public IP address, and the id of the load balancer for potential integration with other services.

# Virtuall network module

The virtual network module, consists of one NSG, one virtual network, and one subnet that is placed in the virtual network. It needs the names of all the resources and the resource group and location where all the resources needs to be placed. It outputs the id of the subnet.

# Database module

The database module creates a sql server and a sql database. It takes a base name for both resources and appends a random string to the end to make them unique. It also needs the name of the resource group and location of where it should be placed. It also takes the administrator_login, administrator_login_password, max_size_gb and sku_name, these are intended to be used to have different values in different enviroments. Outputs the id of the database.

# Storage account module

Creates a storage account and storage container takes the names of the storage container and the storage account, as well as the location and resource group where it should be placed. Outputs the access key of the storage account for integration with other services.
