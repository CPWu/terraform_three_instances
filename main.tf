# # Resource Group
# resource "azurerm_resource_group" "kubernetes_rg" {
#     name                                = var.RESOURCE_GROUP_NAME
#     location                            = var.AZURE_REGION
# }

# # Virtual Network
# resource "azurerm_virtual_network" "kubernetes_vnet" {
#     name                                = "${azurerm_resource_group.kubernetes_rg.name}-vnet"
#     location                            = var.AZURE_REGION
#     resource_group_name                 = var.RESOURCE_GROUP_NAME
#     address_space                       = [var.VNET_ADDRESS_SPACE]
# }

# # Subnet
# resource "azurerm_subnet" "kubernetes_subnet" {
#     name                                = "${var.RESOURCE_GROUP_NAME}-subnet"
#     virtual_network_name                = azurerm_virtual_network.kubernetes_vnet.name
#     resource_group_name                 = var.RESOURCE_GROUP_NAME
#     address_prefixes                    = [var.SUBNET_ADDRESS_PREFIX]
# }

# # Network Security Group
# resource "azurerm_network_security_group" "kubernetes_nsg" {
#     name                                      = "${var.STACK_NAME}-nsg"
#     location                                  = var.AZURE_REGION
#     resource_group_name                       = var.RESOURCE_GROUP_NAME

#     depends_on = [
#         azurerm_resource_group.kubernetes_rg,
#     ]
# }

# # Connect the Network Security Group to the Subnet
# resource "azurerm_subnet_network_security_group_association" "kubernetes_nsg_association" {
#     network_security_group_id                   = azurerm_network_security_group.kubernetes_nsg.id
#     subnet_id                                   = azurerm_subnet.kubernetes_subnet.id
# }

# # Network Security Group - Rule
# resource "azurerm_network_security_rule" "enable_ssh" {
#     name                                        = "SSH"
#     priority                                    = 100
#     direction                                   = "Inbound"
#     access                                      = "Allow"
#     protocol                                    = "TCP"
#     source_port_range                           = "*"
#     destination_port_range                      = "22"
#     source_address_prefix                       = "*"
#     destination_address_prefix                  = "*"
#     resource_group_name                         = var.RESOURCE_GROUP_NAME
#     network_security_group_name                 = azurerm_network_security_group.kubernetes_nsg.name

#     depends_on = [
#         azurerm_network_security_group.kubernetes_nsg
#     ]
# }

# # Network Interface Card
# resource "azurerm_network_interface" "server_nic" {
#     for_each                            = var.SERVER
#     name                                = "${each.value.SERVER_NAME}-nic"
#     location                            = var.AZURE_REGION
#     resource_group_name                 = var.RESOURCE_GROUP_NAME

#     ip_configuration {
#         name                                        = "${each.value.SERVER_NAME}-ip-config"
#         subnet_id                                   = azurerm_subnet.kubernetes_subnet.id
#         private_ip_address_allocation               = "dynamic"
#         public_ip_address_id                        = azurerm_public_ip.sandbox_public_ip[each.key].id
#     }
# }

# # Public IP Address
# resource "azurerm_public_ip" "sandbox_public_ip" {
#     for_each                            = var.SERVER
#     name                                = "${each.value.SERVER_NAME}-public-ip"
#     location                            = var.AZURE_REGION
#     resource_group_name                 = var.RESOURCE_GROUP_NAME
#     allocation_method                   = each.value.IP_TYPE

#     depends_on = [
#         azurerm_resource_group.kubernetes_rg,
#     ]
# }

# # Connect the security group to the network interface card
# resource "azurerm_network_interface_security_group_association" "nic_to_nsg" {
#     for_each                                    = var.SERVER
#     network_interface_id                        = azurerm_network_interface.server_nic[each.key].id
#     network_security_group_id                   = azurerm_network_security_group.kubernetes_nsg.id
# }

# # Linux Virtual Machine
# resource "azurerm_linux_virtual_machine" "server" {
#     for_each                                    = var.SERVER
#     name                                        = each.value.SERVER_NAME
#     resource_group_name                         = var.RESOURCE_GROUP_NAME
#     location                                    = var.AZURE_REGION
#     size                                        = each.value.SERVER_SIZE
#     admin_username                              = each.value.USERNAME
#     admin_password                              = each.value.PASSWORD
#     disable_password_authentication             = false

#     network_interface_ids = [
#         azurerm_network_interface.server_nic[each.key].id
#     ]

#     os_disk {
#         caching                                 = each.value.CACHING
#         storage_account_type                    = each.value.STORAGE_ACCOUNT_TYPE
#     }

#     source_image_reference {
#         publisher                               = each.value.PUBLISHER
#         offer                                   = each.value.OFFER
#         sku                                     = each.value.SKU
#         version                                 = each.value.VERSION
#     }

#     depends_on = [
#         azurerm_network_interface.server_nic
#     ]
# }