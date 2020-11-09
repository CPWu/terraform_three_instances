resource "azurerm_resource_group" "kubernetes_rg" {
    name                                = var.RESOURCE_GROUP_NAME
    location                            = var.AZURE_REGION
}