variable "getsemani_vpc_cidr" {
  description = "VPC CIDR VPC"
  default     = "10.0.0.0/16"
  type        = string
}

variable "getsemani_vpc_tenancy" {
  description = "Instances Tenancy"
  default     = "default"
  type        = string
}

variable "getsemani_vpc_name" {
  description = "Tag Name VPC"
  default     = "main"
  type        = string
}

variable "getsemani_vpc_region" {
  description = "Region VPC"
  default     = "us-east-1"
  type        = string
}

variable "getsemani_vpc_subnet" {
  description = "Configuracion Subnet."
  type = map(object({
    cidr   = string
    az     = string
    public = bool
  }))

  default = {
    pubA = {
      cidr   = "10.0.10.0/24",
      az     = "us-east-1a",
      public = true
    },

    privB = {
      cidr   = "10.0.20.0/24",
      az     = "us-east-1b",
      public = false
    }
  }

}
