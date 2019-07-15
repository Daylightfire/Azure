#################################################################
##########
#   Network related Variables
##########
#################################################################

# Generic
variable resource_group_name {}

variable location {}

# Vnet and Subnets
variable address_space {}

variable dns_servers {
  type = "list"
}
variable "hubsubnet_name" {}
variable "hubsubnet_prefix" {}
variable "pressubnet_name" {}
variable "pressubnet_prefix" {}
variable "appsubnet_name" {}
variable "appsubnet_prefix" {}
variable "datasubnet_name" {}
variable "datasubnet_prefix" {}

# NSGs

variable "jump_private_ip_address" {}
variable "hubrdp" {}
variable "jumpext" {}

variable "presrdp" {}
variable "datardp" {}




