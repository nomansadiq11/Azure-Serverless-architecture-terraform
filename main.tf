resource "azurerm_resource_group" "serverless-rg" {
  name     = "${var.resouce_group_name}"
  location = "${var.location}"

  tags = {
    environment = "${var.tag}"
  }
}


resource "azurerm_storage_account" "SA_serverless" {
  name                     = "saserverless"
  resource_group_name      = "${azurerm_resource_group.serverless-rg.name}"
  location                 = "${var.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"

   tags = {
    environment = "${var.tag}"
  }

}


## Payment response update


resource "azurerm_app_service_plan" "ASP_Serverless_fn" {
  name                = "Serverless_fn"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.serverless-rg.name}"

  sku {
    tier = "Standard"
    size = "S1"
  }

   tags = {
    environment = "${var.tag}"
  }
}


## Cosmos DB create account



resource "azurerm_cosmosdb_account" "cosmos_serverless" {
  name                = "serverless-${random_integer.ri.result}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.serverless-rg.name}"
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  enable_automatic_failover = false
  enable_multiple_write_locations = false


  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }

  geo_location {
    location          = "${var.failover_location}"
    failover_priority = 0
  }

  # geo_location {
  #   prefix            = "paymentfacadedev-db-${random_integer.ri.result}-customid"
  #   location          = "${var.location}"
  #   failover_priority = 0
  # }


}



## Cosmos DB  create account



## Service BUS

resource "azurerm_servicebus_namespace" "SBserverless" {
  name                = "SBServerless"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.serverless-rg.name}"
  sku                 = "Standard"

  tags = {
    source = "${var.tag}"
  }
}

resource "azurerm_servicebus_queue" "messagequeue" {
  name                = "messagequeue"
  resource_group_name = "${azurerm_resource_group.serverless-rg.name}"
  namespace_name      = "${azurerm_servicebus_namespace.SBserverless.name}"

  enable_partitioning = true
}


resource "azurerm_resource_group" "testwebapp" {
  name     = "teswebapp"
  location = "${var.location}"

  tags = {
    environment = "${var.tag}"
  }
}


resource "azurerm_servicebus_topic" "topicname" {
  name                = "topicname"
  resource_group_name = "${azurerm_resource_group.serverless-rg.name}"
  namespace_name      = "${azurerm_servicebus_namespace.SBserverless.name}"

  enable_partitioning = true
}



# Web App services


# resource "azurerm_app_service_plan" "serverless_ASP" {
#   name                = "${random_string.fqdn.result}"
#   location            = "${var.location}"
#   resource_group_name = "${azurerm_resource_group.testwebapp.name}"
#   kind                = "Linux"
#   reserved            = true
  
#   sku {
#     tier = "Basic"
#     size = "B1"
#     capacity = 1
#   }
# }

# resource "azurerm_app_service" "serverlesswebapp_AS" {
#   name                = "${random_string.fqdn.result}"
#   location            = "${var.location}"
#   resource_group_name = "${azurerm_resource_group.testwebapp.name}"
#   app_service_plan_id = "${azurerm_app_service_plan.ASP_Serverless_fn.id}"

#   site_config {
#     dotnet_framework_version    = "v4.0"
#     scm_type                    = "None"
#     linux_fx_version            = "DOTNETCORE|3.0"
#     ftps_state                  = "AllAllowed"
#   }

  
# }

# web app service