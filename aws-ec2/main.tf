

data "aws_ami" "ec2_server_ami" {
  region      = var.ec2_server_region
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.12.*.0-kernel-6.18-x86_64"]
  }

}

resource "aws_instance" "ec2_server" {
  ami           = data.aws_ami.ec2_server_ami.id
  instance_type = var.ec2_server_type

  tags = {
    Name = var.ec2_server_name
  }
}
