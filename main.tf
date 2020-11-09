# Resource Group
resource "azurerm_resource_group" "kubernetes_rg" {
    name                                = var.RESOURCE_GROUP_NAME
    location                            = var.AZURE_REGION
}

# Virtual Network
resource "azurerm_virtual_network" "kubernetes_vnet" {
    name                                = "${azurerm_resource_group.kubernetes_rg.name}-vnet"
    location                            = var.AZURE_REGION
    resource_group_name                 = var.RESOURCE_GROUP_NAME
    address_space                       = [var.VNET_ADDRESS_SPACE]
}

# Subnet
resource "azurerm_subnet" "kubernetes_subnet" {
    name                                = "${var.RESOURCE_GROUP_NAME}-subnet"
    virtual_network_name                = azurerm_virtual_network.kubernetes_vnet.name
    resource_group_name                 = var.RESOURCE_GROUP_NAME
    address_prefixes                    = [var.SUBNET_ADDRESS_PREFIX]
}

# Network Interface Card
resource "azurerm_network_interface" "server_nics" {
    for_each                            = var.SERVER
    name                                = each.value.SERVER_NAME
    location                            = var.AZURE_REGION
    resource_group_name                 = var.RESOURCE_GROUP_NAME
}
