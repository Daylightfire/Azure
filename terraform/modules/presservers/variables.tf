#################################################################
##########
#   Variables for Servers in the Pres subnet
##########
#################################################################

# Generic

variable "pres_subnet_id" {}
variable "resource_group_name" {}

variable "location" {}

variable "admin_username" {}

variable "admin_password" {}

# Web Server
variable "web_prefix" {}

variable "web_private_ip_address" {}

variable "active_directory_domain" {}

variable "active_directory_netbios_name" {
  description = "The netbios name of the Active Directory domain, for example `consoto`"
}

variable "active_directory_username" {}

variable "active_directory_password" {}

