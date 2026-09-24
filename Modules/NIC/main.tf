resource "azurerm_network_interface" "nic" {
  for_each = var.nics

  name                = each.value.nic_name
  resource_group_name = each.value.rgname
  location            = each.value.location

  ip_configuration {
    name                          = "configuration"
    subnet_id                     = data.azurerm_subnet.snet[each.key].id
    private_ip_address_allocation = each.value.ip_address_allocation
    public_ip_address_id          = data.azurerm_public_ip.pip[each.key].id

  }
}


data "azurerm_subnet" "snet" {
  for_each             = var.nics
  name                 = each.value.snet_name
  resource_group_name  = each.value.rgname
  virtual_network_name = each.value.vnet_name
}

data "azurerm_public_ip" "pip" {
  for_each            = var.nics
  name                = each.value.pip_name
  resource_group_name = each.value.rgname

}