variable "ec2_server_region" {
  type        = string
  description = "Region"
  default     = "us-east-1"
}

variable "ec2_server_type" {
  type        = string
  description = "Instance Type"
  default     = "t2.micro"
}

variable "ec2_server_name" {
  type        = string
  description = "Name Instance"
  default     = "Hello World"
}
  