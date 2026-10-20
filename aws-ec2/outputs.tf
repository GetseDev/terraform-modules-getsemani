output "ec2-server-public-ip" { 
  value = aws_instance.ec2_server.public_ip
}

output "ec2-server-instance-type" {
  value = aws_instance.ec2_server.instance_type
}

output "ec2-server-arn" {
  value = aws_instance.ec2_server.arn
}
