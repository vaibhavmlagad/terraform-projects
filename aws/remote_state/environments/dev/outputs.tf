output "instance_id" {
  value = aws_instance.web.id
  description = "EC2 instance ID"
}

output "public_ip" {
  value = aws_instance.web.public_ip
  description = "EC2 instance public IP address"
}

output "public_dns" {
  value = aws_instance.web.public_dns
  description = "EC2 instance public DNS name"
}

output "private_ip" {
  value = aws_instance.web.private_ip
  description = "EC2 instance private IP address"
}