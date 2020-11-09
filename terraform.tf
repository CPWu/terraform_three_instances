terraform {
    backend "azurerm" {
        tenant_id                               = var.TENANT_ID
        subscription_id                         = var.SUBSCRIPTION_ID
        resource_group_name                     = "remote-state"
        storage_account_name                    = "cpwu"
        container_name                          = "tfstate"
        key                                     = "threeinstances.tfstate"
    }
}