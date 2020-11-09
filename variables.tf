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
variable "cluster" {
    type = map
    default = {
        masterNode = {

        },
        slaveNodeOne = {

        },
        slaveNodeTwo = {

        }
    }
}

# Cluster Configuration
variable "RESOURCE_GROUP_NAME" {
    type                            = string
    default                         = "sandbox-rg"
    description                     = "Name of the resource group where resources will be created"
}
variable "AZURE_REGION" {
    type                            = string
    default                         = "canadacentral"
    description                     = "The region the resources will be created in"
}