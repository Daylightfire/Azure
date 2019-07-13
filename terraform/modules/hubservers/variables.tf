#######################################################
# Hub Vars
#######################################################

# Misc

variable "hub_subnet_id" {}
variable "resource_group_name" {}

variable "location" {}

variable "admin_username" {}

variable "admin_password" {}

# Jump box
variable "jump_prefix" {}

variable "jump_private_ip_address" {}






# active directory

variable "dc1_prefix" {}

variable "dc1_private_ip_address" {}

#variable "dc1_subnet_id" {}

variable "active_directory_domain" {}
variable "active_directory_netbios_name" {}






