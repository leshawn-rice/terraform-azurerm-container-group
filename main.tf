# ACI is container groups
# https://learn.microsoft.com/en-us/azure/container-instances/container-instances-quickstart-terraform

resource "azurerm_container_group" "this" {
  name                = var.name != null ? var.name : module.name[0].name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  os_type             = var.os_type
  ip_address_type     = var.ip_address_type
  restart_policy      = var.restart_policy
  dns_name_label      = var.dns_name_label
  zones               = var.zones

  subnet_ids = var.subnet_ids

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "image_registry_credential" {
    for_each = var.image_registry_credentials
    iterator = credential

    content {
      server                    = credential.value.server
      username                  = credential.value.username
      password                  = credential.value.password
      user_assigned_identity_id = credential.value.user_assigned_identity_id
    }
  }

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
        for_each = container.value.ports != null ? container.value.ports : []
        iterator = port

        content {
          port     = port.value.port
          protocol = port.value.protocol
        }
      }

      dynamic "volume" {
        for_each = container.value.volume != null ? [container.value.volume] : []
        iterator = volume

        content {
          name                 = volume.value.name
          mount_path           = volume.value.mount_path
          read_only            = volume.value.read_only
          empty_dir            = volume.value.empty_dir
          storage_account_name = volume.value.storage_account_name
          storage_account_key  = volume.value.storage_account_key
          share_name           = volume.value.share_name
          secret               = volume.value.secret
        }
      }
    }
  }

  dynamic "diagnostics" {
    for_each = var.diagnostics != null ? [var.diagnostics] : []

    content {
      log_analytics {
        workspace_id  = diagnostics.value.workspace_id
        workspace_key = diagnostics.value.workspace_key
        log_type      = diagnostics.value.log_type
        metadata      = diagnostics.value.metadata
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

  lifecycle {
    # A container group is often started, stopped and stamped by whatever
    # orchestrates it at runtime. Those tags are not terraform's to own.
    ignore_changes = [
      tags["started_at"],
      tags["purpose"],
    ]
  }
}
