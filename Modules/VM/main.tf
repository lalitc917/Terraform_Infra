data "azurerm_network_interface" "nic" {
  for_each = var.vms
   name                = each.value.nic_name
   resource_group_name = each.value.rgname
}

resource "azurerm_virtual_machine" "vms" {
  for_each              = var.vms
  name                  = each.value.vm_name
  location              = each.value.location
  resource_group_name   = each.value.rgname
  network_interface_ids = [data.azurerm_network_interface.nic[each.key].id]
  vm_size               = each.value.vm_size


  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = each.value.disk-name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password@1234"
  }
  os_profile_linux_config {
    disable_password_authentication = false

  }
}