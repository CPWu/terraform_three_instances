output "public_ips" {
    description             = "List of public ip addresses created by this module"
    value                   = data.azurerm_public_ip.public_ips.*.ip_address
}