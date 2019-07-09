variable "loc" {
  description = "Default Azure region"
  default = "westeurope"
}

variable "tags" {
  default       ={
      source    = "POC"
      env       = "TEST"     
  }
}