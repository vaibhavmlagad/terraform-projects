terraform {

    backend "s3" {
        # The backend configuration is moved to a separate file for better organization and security.
        # The file is located at "environments/conf/backend-dev.conf" and contains the following configuration:
        # bucket  = "955030483517-terraform-states"
        # key     = "dev/service-name.tfstate"
        # region  = "ap-south-1"
        # dynamodb_table = "terraform-lock"
        # encrypt = true
    }
  
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.16"
        }
    }

    required_version = ">= 1.2.0"
}

provider "aws" {
    region = var.aws_region
}

resource "aws_instance" "my_dev_server" {
    ami           = var.ami_id
    instance_type = var.instance_type

    tags = {
        Name = var.instance_name
    }
}