
# Generic Info
variable "loc" {
  description = "Default Azure region"
  default = "westeurope"
}

variable "domainname" {
  default = "rootops.local"
}

# jump servers
variable "jumpname" {
  default  = "vm-poc-hub-jump"  
}
# dc servers
variable "dcname" {
  default = "vm-poc-hub-dc"
}
variable "adminus" {
  default = "zerocool"
}

variable "adminpa" {
  default = ""
  
}




