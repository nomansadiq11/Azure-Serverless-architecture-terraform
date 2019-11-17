terraform {
  backend "azurerm" {
    resource_group_name  = "ForTerraformStates"
    storage_account_name = "manageterraformstates"
    container_name       = "terraformprojectsstates"
    key                  = "serverless.terraform.tfstate"
  }
}