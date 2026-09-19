module "name" {
  source  = "leshawn-rice/standard-naming/azurerm"
  version = "1.1.0"

  count = var.name == null ? 1 : 0

  resource_type   = "ci"
  application     = var.application
  environment     = var.environment
  location        = var.location
  business_unit   = var.business_unit
  workload        = var.workload
  instance_number = var.instance_number
}
