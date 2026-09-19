

<!-- BEGIN_TF_DOCS -->
### Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 5.6.0, < 6.0.0 |

### Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The Name which should be used for this Resource Group. Changing this forces a new Resource Group to be created.<br/><br/>  If 'name' is not passed, the 'names' module will be called to create a name | `string` | `null` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU for the container group (e.g., 'Standard'). | `string` | `"Standard"` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | The operating system type of the container group (e.g., 'Linux' or 'Windows'). | `string` | `"Linux"` | no |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | Specifies the IP address type for the container group (e.g., 'Public' or 'Private'). | `string` | `"Private"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet IDs to which this container group should be connected. | `list(string)` | `[]` | no |
| <a name="input_containers"></a> [containers](#input\_containers) | A list of container definitions. Each object should include:<br/>- name, image, cpu, memory (required)<br/>- cpu\_limit, memory\_limit (optional)<br/>- environment\_variables, secure\_environment\_variables (optional)<br/>- commands (optional)<br/>- ports (optional list of port objects)<br/>- volume (optional single volume object) | <pre>list(object({<br/>    name         = string<br/>    image        = string<br/>    cpu          = number<br/>    memory       = number<br/>    cpu_limit    = optional(number)<br/>    memory_limit = optional(number)<br/><br/>    # Environment variables<br/>    environment_variables        = optional(map(string))<br/>    secure_environment_variables = optional(map(string))<br/><br/>    # Commands to execute on container start<br/>    commands = optional(list(string))<br/><br/>    # Ports<br/>    ports = optional(list(object({<br/>      port     = number<br/>      protocol = string<br/>    })))<br/><br/>    # Volume (optional)<br/>    volume = optional(object({<br/>      name                 = string<br/>      mount_path           = string<br/>      read_only            = optional(bool)<br/>      empty_dir            = optional(bool)<br/>      storage_account_name = optional(string)<br/>      storage_account_key  = optional(string)<br/>      share_name           = optional(string)<br/>      secret               = optional(map(string))<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_restart_policy"></a> [restart\_policy](#input\_restart\_policy) | (Optional) Restart policy for the container group. Possible values are Always, Never and OnFailure. Defaults to Always. | `string` | `"Always"` | no |
| <a name="input_dns_name_label"></a> [dns\_name\_label](#input\_dns\_name\_label) | (Optional) The DNS label/name for the container group's IP. Only valid when ip\_address\_type is Public. | `string` | `null` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | (Optional) A list of Availability Zones in which this Container Group is located. | `list(string)` | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) An identity block:<br/>    type         - (Required) SystemAssigned, UserAssigned or 'SystemAssigned, UserAssigned'.<br/>    identity\_ids - (Optional) A list of User Assigned Identity IDs. Required when type includes UserAssigned. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_image_registry_credentials"></a> [image\_registry\_credentials](#input\_image\_registry\_credentials) | (Optional) One or more image\_registry\_credential blocks, used to pull images from a private registry:<br/>    server                    - (Required) The address to use to connect to the registry, e.g. myacr.azurecr.io.<br/>    username / password       - (Optional) Registry credentials. Omit when pulling with a managed identity.<br/>    user\_assigned\_identity\_id - (Optional) The User Assigned Identity used to pull the image. Preferred over username/password. | <pre>list(object({<br/>    server                    = string<br/>    username                  = optional(string)<br/>    password                  = optional(string)<br/>    user_assigned_identity_id = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_diagnostics"></a> [diagnostics](#input\_diagnostics) | (Optional) A diagnostics block which ships container logs to a Log Analytics Workspace:<br/>    workspace\_id  - (Required) The Workspace (Customer) ID of the Log Analytics Workspace.<br/>    workspace\_key - (Required) The Workspace Key of the Log Analytics Workspace.<br/>    log\_type      - (Optional) ContainerInsights or ContainerInstanceLogs. Defaults to ContainerInsights.<br/>    metadata      - (Optional) Any metadata to be included in the diagnostics. | <pre>object({<br/>    workspace_id  = string<br/>    workspace_key = string<br/>    log_type      = optional(string, "ContainerInsights")<br/>    metadata      = optional(map(string))<br/>  })</pre> | `null` | no |
| <a name="input_application"></a> [application](#input\_application) | n/a | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `null` | no |
| <a name="input_business_unit"></a> [business\_unit](#input\_business\_unit) | n/a | `string` | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | n/a | `string` | `null` | no |
| <a name="input_instance_number"></a> [instance\_number](#input\_instance\_number) | n/a | `string` | `null` | no |
| <a name="input_service"></a> [service](#input\_service) | n/a | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags which should be assigned to the Resource Group<br/><br/>  If 'tags' is not passed, the 'tags' module will be called to create tags | `map(string)` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | n/a | <pre>object({<br/>    create = optional(string, "30m")<br/>    read   = optional(string, "30m")<br/>    update = optional(string, "5m")<br/>    delete = optional(string, "30m")<br/>  })</pre> | <pre>{<br/>  "create": "30m",<br/>  "delete": "30m",<br/>  "read": "30m",<br/>  "update": "5m"<br/>}</pre> | no |

### Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Resource Group. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Resource Group. |
| <a name="output_location"></a> [location](#output\_location) | The Azure Region where the Resource Group exists. |
| <a name="output_ip_address"></a> [ip\_address](#output\_ip\_address) | The IP address allocated to the Container Group. |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The FQDN of the Container Group, when a dns\_name\_label is set. |
| <a name="output_identity_principal_id"></a> [identity\_principal\_id](#output\_identity\_principal\_id) | The Principal ID of the Container Group's managed identity, if one is configured. |
<!-- END_TF_DOCS -->