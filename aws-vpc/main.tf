resource "aws_vpc" "getsemani_vpc" {
  cidr_block       = var.getsemani_vpc_cidr
  instance_tenancy = var.getsemani_vpc_tenancy
  region           = var.getsemani_vpc_region

  tags = {
    Name = "${var.getsemani_vpc_name}-vpc"
  }
}

resource "aws_internet_gateway" "getsemani_vpc_igw" {
  vpc_id = aws_vpc.getsemani_vpc.id
  region = var.getsemani_vpc_region

  tags = {
    Name = "${var.getsemani_vpc_name}-igw"
  }
}

resource "aws_subnet" "getsemani_vpc_subnet" {
  for_each                = var.getsemani_vpc_subnet
  vpc_id                  = aws_vpc.getsemani_vpc.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = each.value.public

  tags = {
    Name = "${var.getsemani_vpc_name}-subnet-${each.key}"
  }

}
