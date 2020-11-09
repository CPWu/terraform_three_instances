# Provider Variables
variable "SUBSCRIPTION_ID" {
    type = string
}
variable "CLIENT_ID" {
    type = string
}
variable "CLIENT_SECRET" {
    type = string
}
variable "TENANT_ID" {
    type = string
}

# Node Configuration - For Each
variable "SERVER" {
    description     = "Map of Server Configuration"
    type = map
    default = {
        masterNode = {
            SERVER_NAME            = "masternode"
        },
        slaveNodeOne = {
            SERVER_NAME            = "slavenode01"
        },
        slaveNodeTwo = {
            SERVER_NAME            = "slavenode02"            
        }
    }
}

# Cluster Configuration
variable "RESOURCE_GROUP_NAME" {
    type                            = string
    default                         = "kubernetes-rg"
    description                     = "Name of the resource group where resources will be created"
}
variable "AZURE_REGION" {
    type                            = string
    default                         = "canadacentral"
    description                     = "The region the resources will be created in"
}
variable "VNET_ADDRESS_SPACE" {
    type                            = string
    default                         = "10.0.0.0/16"
    description                     = "Virtual Network address space"
}
variable "SUBNET_ADDRESS_PREFIX" {
    type                            = string
    default                         = "10.0.2.0/24"
    description                     = "Subet address space"   
}