#################################################################
##########
#   Main Variable file
##########
#################################################################

#   Generic info
variable "location" {
    description = "Default Azure reigon"
    default     = "westeurope"
}
variable "resource_group_name" {
    description = "Default Resource Group"
    default     = "rg-poc"
}

variable "active_directory_domain"  {
    default       = "rootops.local"
}

#######################################################
#   Network
#######################################################
variable "address_space" {
    description = "Default Vnet Address Space"
    default = "10.1.0.0/16"
}

variable "dns_servers" {
    default = ["10.1.0.5", "10.1.0.6"]
}

variable "hubsubnet_name" {
    default = "sn-hub"
}

variable "hubsubnet_prefix" {
    default = "10.1.0.0/24"
}

variable "pressubnet_name" {
    default = "sn-pres"
}

variable "pressubnet_prefix" {
    default = "10.1.1.0/24"
}

variable "appsubnet_name" {
    default = "sn-app"
}

variable "appsubnet_prefix" {
    default = "10.1.2.0/24"
}

variable "datasubnet_name" {
    default = "sn-data"
}

variable "datasubnet_prefix" {
    default = "10.1.3.0/24"
}

# NSGs

variable "jumpext" {
    default = "externalaccess"
}
variable "hubrdp" {
    default = "hubrdpaccess"
}

variable "presrdp" {
    default = "presaccess"
}

variable "datardp" {
    default = "dataaccess"  
}



#######################################################
# Hub Vars
#######################################################

# Misc
variable "admin_username" {
  default   = "zerocool"
}

variable "admin_password" {}


# Jump box
variable "jump_prefix" {
    default = "jumpbox"
}

variable "jump_private_ip_address" {
    default = "10.1.0.4"
}

# Active Directory and DC 1
variable "dc1_prefix" {
    default = "dcbox"
}

variable "dc1_private_ip_address" {
    default = "10.1.0.5"
}


#######################################################
# pres Vars
#######################################################




# Web Server
variable "web_prefix" {
    default     = "webbox"
}

variable "web_private_ip_address" {
    default = "10.1.1.5"
    }



#######################################################
# sql vars
#######################################################

variable "sql_prefix" {
    default     = "sqlpoc"
}

variable "lbprivate_ip_address" {
    default     = "10.1.3.5"
}

variable "sqlvmcount" {
  default       = "2"
}

variable "sqlpip_prefix" {
    default     = "10.1.3."  
}





