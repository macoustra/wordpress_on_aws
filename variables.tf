variable "host_os" {
  type    = string
  default = "linux"
}

variable "CIDR_BLOCK" {
  default = "0.0.0.0/0"
}

variable "AWS_REGION" { 
  default = "eu-central-1"
  description = "AWS Region"  
}