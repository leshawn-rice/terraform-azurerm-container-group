
resource "azurerm_container_group" "this" {
  name                = var.name != null ? var.name : module.name[0].name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  os_type             = var.os_type
  ip_address_type     = var.ip_address_type

  subnet_ids = var.subnet_ids

  dynamic "container" {
    for_each = var.containers
    iterator = container

    content {
      name  = container.value.name
      image = container.value.image

      cpu          = container.value.cpu
      memory       = container.value.memory
      cpu_limit    = container.value.cpu_limit
      memory_limit = container.value.memory_limit

      environment_variables        = container.value.environment_variables
      secure_environment_variables = container.value.secure_environment_variables

      commands = container.value.commands

      dynamic "ports" {
        for_each = container.value.ports
        iterator = port

        content {
          port     = port.value.port
          protocol = port.value.protocol
        }
      }

      dynamic "volume" {
        for_each = container.value.volume ? [container.value.volume] : []
        iterator = volume

        content {
          name                 = volume.name
          mount_path           = volume.mount_path
          read_only            = volume.read_only
          empty_dir            = volume.empty_dir
          storage_account_name = volume.storage_account_name
          storage_account_key  = volume.storage_account_key
          share_name           = volume.share_name
          secret               = volume.secret
        }
      }
    }
  }

  tags = var.tags != null ? var.tags : module.tags[0].tags

  timeouts {
    create = var.timeouts.create
    read   = var.timeouts.read
    update = var.timeouts.update
    delete = var.timeouts.delete
  }
}
