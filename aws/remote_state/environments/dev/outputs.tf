output "instance_id" {
  value = aws_instance.my_dev_server.id
  description = "EC2 instance ID"
}

output "public_ip" {
  value = aws_instance.my_dev_server.public_ip
  description = "EC2 instance public IP address"
}

output "public_dns" {
  value = aws_instance.my_dev_server.public_dns
  description = "EC2 instance public DNS name"
}

output "private_ip" {
  value = aws_instance.my_dev_server.private_ip
  description = "EC2 instance private IP address"
}