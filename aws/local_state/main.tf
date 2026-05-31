terraform {

    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.16"
        }
    }

    required_version = ">= 1.2.0"
}

provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "my_demo_server" {
    ami           = "ami-07a00cf47dbbc844c"
    instance_type = "t3.micro"

    tags = {
        Name = "TerraformExampleInstance"
    }
}