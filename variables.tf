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
            SERVER_NAME             = "masternode"
            IP_TYPE                 = "Dynamic"
            SERVER_SIZE             = "Standard_B1s"
            USERNAME                = "myadmin"
            PASSWORD                = "Password123"
            # OS Disk
            CACHING                 = "ReadWrite"
            STORAGE_ACCOUNT_TYPE    = "Standard_LRS"
            # Source Image Reference
            PUBLISHER               = "Canonical"
            OFFER                   = "UbuntuServer"
            SKU                     = "18.04-LTS"
            VERSION                 = "latest"
        },
        slaveNodeOne = {
            SERVER_NAME             = "slavenode01"
            IP_TYPE                 = "Dynamic"
            SERVER_SIZE             = "Standard_B1s"
            USERNAME                = "myadmin"
            PASSWORD                = "Password123"
            # OS Disk
            CACHING                 = "ReadWrite"
            STORAGE_ACCOUNT_TYPE    = "Standard_LRS"
            # Source Image Reference
            PUBLISHER               = "Canonical"
            OFFER                   = "UbuntuServer"
            SKU                     = "18.04-LTS"
            VERSION                 = "latest"           
        },
        slaveNodeTwo = {
            SERVER_NAME             = "slavenode02" 
            IP_TYPE                 = "Dynamic"
            SERVER_SIZE             = "Standard_B1s"
            USERNAME                = "myadmin"
            PASSWORD                = "Password123"
            # OS Disk
            CACHING                 = "ReadWrite"
            STORAGE_ACCOUNT_TYPE    = "Standard_LRS"
            # Source Image Reference
            PUBLISHER               = "Canonical"
            OFFER                   = "UbuntuServer"
            SKU                     = "18.04-LTS"
            VERSION                 = "latest"
        }
    }
}

# Cluster Configuration
variable "STACK_NAME" {
    type                            = string
    default                         = "kubernetes"
    description                     = "Identifier used for this entire stack or project"
}
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