variable "aws_region" {
    description = "AWS region to deploy resources"
    type        = string
    default     = "ap-south-1"  
}

variable "ami_id" {
    description = "AMI ID for the EC2 instance"
    type        = string
    default     = "ami-07a00cf47dbbc844c"  
}

variable "instance_type" {
    description = "EC2 instance type"
    type        = string
    default     = "t3.micro"  
}

variable "instance_name" {
    description = "Name tag for the EC2 instance"
    type        = string
    default     = "TerraformExampleInstance"  
}