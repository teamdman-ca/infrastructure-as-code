variable "azure_ad_admins_group_name" {
  type = string
}
variable "azure_ad_admins_group_member_object_ids" {
    type = set(string)
}
resource "azuread_group" "admins" {
    display_name = var.azure_ad_admins_group_name
    members = var.azure_ad_admins_group_member_object_ids
    security_enabled = true
}