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
    name                                = "${each.value.SERVER_NAME}-nic"
    location                            = var.AZURE_REGION
    resource_group_name                 = var.RESOURCE_GROUP_NAME

    ip_configuration {
        name                                      = "${each.value.SERVER_NAME}-ip-config"
        subnet_id                                 = azurerm_subnet.kubernetes_subnet.id
        private_ip_address_allocation             = "dynamic"  
    }
}

# Public IP Address
resource "azurerm_public_ip" "sandbox_public_ip" {
    for_each                            = var.SERVER
    name                                = "${each.value.SERVER_NAME}-public-ip"
    location                            = var.AZURE_REGION
    resource_group_name                 = var.RESOURCE_GROUP_NAME
    allocation_method                   = each.value.IP_TYPE
}