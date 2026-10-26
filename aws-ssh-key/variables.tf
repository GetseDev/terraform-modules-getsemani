variable "getsemani_ssh_key_rsa_bits" {
  default = 4096
  type    = number
}

variable "getsemani_ssh_key_aws_key_name" {
  default = "key"
  type    = string
}

variable "getsemani_ssh_key_directory" {
  type    = string
  default = "./"
}

variable "getsemani_ssh_key_file_permission" {
  default = 0400
  type    = number
}