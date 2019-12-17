# Azure Serverless architecture terraform

The repo will generate the serverless architecture for the application which include following services

## Prerequisite

- Azure Credentials on CLI

## State

- Local State
- Remote State (remote_state.tf)

## Resouces will be spin up 

- Resouce Group
- Web App Service
- Storage Account
- Azure Function
- Services Bus
    - Queue
    - Topic
- Cosmos DB (SQL)
- App Service Plan for Azure Function
- App Service Plan for Web App




## Variables

| Variable      | Value | Description |
| ------------- | ------------- | ------------- | 
| resouce_group_name       | serverless   | resouce group name |
| tag | Dev/Stage  | Give tag name to resoues |
| location | West Europe  | Location where resouces will be created |
| failover_location | North Europe  | Location for cosmos DB |

