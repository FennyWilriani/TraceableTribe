variable "location" {
  default     = "westeurope"
  description = "Location of the resource group."
}

variable "prefix" {
    description = "customer prefix"
    default = "uzg"
}

variable "vnet_range" {
  type        = list(string)
  default     = ["10.2.0.0/16"]
  description = "Address range for deployment VNet"
}

variable "subnet_range" {
  type        = list(string)
  default     = ["10.2.0.0/24"]
  description = "Address range for session host subnet"
}