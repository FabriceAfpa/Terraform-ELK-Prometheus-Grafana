# terraform {
#   required_providers {
#     scaleway = {
#       source  = "scaleway/scaleway"
#       version = "2.0.0"
#     }
#   }
# }

variable "disk_size" {
  type = number
  default = 30
}

variable "instance_type" {
  type = string
  default = "DEV1-S"
}
variable "instance_typeXL" {
  type = string
  default = "DEV1-XL"
}

variable "instance_count" {
  type = number
  default = 3
}

output "ip_instance" {
   value = scaleway_instance_ip.public_ip[*].address
}
