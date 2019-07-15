variable "resource_group_name" {}

variable "location" {}

variable "active_directory_domain" {}
variable "active_directory_netbios_name" {
  description = "The netbios name of the Active Directory domain, for example `consoto`"
}

variable "active_directory_username" {}

variable "active_directory_password" {}


variable "data_subnet_id" {}

variable "admin_username" {}

variable "admin_password" {}

variable "sql_prefix" {}

variable "lbprivate_ip_address" {}

variable "sqlvmcount" {}

variable "sqlpip_prefix" {}
