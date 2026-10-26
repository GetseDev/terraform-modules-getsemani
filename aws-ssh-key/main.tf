resource "tls_private_key" "getsemani_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = var.getsemani_ssh_key_rsa_bits
}

resource "aws_key_pair" "getsemani_aws_key_pair" {
  key_name   = var.getsemani_ssh_key_aws_key_name
  public_key = tls_private_key.getsemani_ssh_key.public_key_openssh

  tags = {
    Name = var.getsemani_ssh_key_aws_key_name
  }

}

resource "local_file" "getsemani_local_file_private_key" {
  content         = tls_private_key.getsemani_ssh_key.private_key_pem
  filename        = "${var.getsemani_ssh_key_directory}/${var.getsemani_ssh_key_aws_key_name}"
  file_permission = var.getsemani_ssh_key_file_permission
}
