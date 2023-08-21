variable "cidr_block" {
  default = "172.0.0.0/16"
}

variable "publicSubnet" {
  default = "172.0.1.0/24"
}

variable "privateSubnet" {
  default = "172.0.2.0/24"
}

variable "availabilityzone" {
  default = "us-east-1a"
}