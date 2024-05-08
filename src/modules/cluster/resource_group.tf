variable "resource_group_name" {
  type = string
}
variable "resource_group_location" {
  type = string
}
variable "resource_group_tags" {
  type = map(string)
}
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.resource_group_location
  tags = var.resource_group_tags
}
