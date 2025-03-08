variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created."
}

variable "name" {
  type        = string
  description = <<DESCRIPTION
  (Optional) The Name which should be used for this Resource Group. Changing this forces a new Resource Group to be created.
  
  If 'name' is not passed, the 'names' module will be called to create a name
  DESCRIPTION
  default     = null
}

variable "sku" {
  type        = string
  description = "The SKU for the container group (e.g., 'Standard')."
  default     = "Standard"
}

variable "os_type" {
  type        = string
  description = "The operating system type of the container group (e.g., 'Linux' or 'Windows')."
  default     = "Linux"
}

variable "ip_address_type" {
  type        = string
  description = "Specifies the IP address type for the container group (e.g., 'Public' or 'Private')."
  default     = "Private"
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs to which this container group should be connected."
  default     = []
}

variable "containers" {
  type = list(object({
    name         = string
    image        = string
    cpu          = number
    memory       = number
    cpu_limit    = optional(number)
    memory_limit = optional(number)

    # Environment variables
    environment_variables        = optional(map(string))
    secure_environment_variables = optional(map(string))

    # Commands to execute on container start
    commands = optional(list(string))

    # Ports
    ports = optional(list(object({
      port     = number
      protocol = string
    })))

    # Volume (optional)
    volume = optional(object({
      name                 = string
      mount_path           = string
      read_only            = optional(bool)
      empty_dir            = optional(bool)
      storage_account_name = optional(string)
      storage_account_key  = optional(string)
      share_name           = optional(string)
      secret               = optional(map(string))
    }))
  }))
  description = <<EOT
A list of container definitions. Each object should include:
- name, image, cpu, memory (required)
- cpu_limit, memory_limit (optional)
- environment_variables, secure_environment_variables (optional)
- commands (optional)
- ports (optional list of port objects)
- volume (optional single volume object)
EOT
  default     = []
}

variable "application" {
  type        = string
  description = ""
  default     = null
}
variable "environment" {
  type        = string
  description = ""
  default     = null
}
variable "business_unit" {
  type        = string
  description = ""
  default     = null
}
variable "workload" {
  type        = string
  description = ""
  default     = null
}
variable "instance_number" {
  type        = string
  description = ""
  default     = null
}
variable "service" {
  type        = string
  description = ""
  default     = null
}

variable "tags" {
  type        = map(string)
  description = <<DESCRIPTION
  (Optional) A mapping of tags which should be assigned to the Resource Group
  
  If 'tags' is not passed, the 'tags' module will be called to create tags
  DESCRIPTION
  default     = null
}

variable "timeouts" {
  type = object({
    create = optional(string, "30m")
    read   = optional(string, "30m")
    update = optional(string, "5m")
    delete = optional(string, "30m")
  })
  default = {
    create = "30m"
    read   = "30m"
    update = "5m"
    delete = "30m"
  }
}
