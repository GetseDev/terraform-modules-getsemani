output "getsemani_ssh_key_name" {
  description = "Key pair name in AWS"
  value       = aws_key_pair.getsemani_aws_key_pair.key_name
}

output "getsemani_ssh_key_algorithm" {
  description = "Key pair algorithm"
  value       = tls_private_key.getsemani_ssh_key.algorithm
}

output "getsemani_ssh_key_private_key_path" {
  description = "Private key file path on disk, relative to the working directory"
  value       = local_file.getsemani_local_file_private_key.filename
}

output "getsemani_ssh_key_public_key_openssh" {
  description = "Public key in OpenSSH format"
  value       = tls_private_key.getsemani_ssh_key.public_key_openssh
}
