terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "EC2Instance" {
    ami = "ami-0742b4e673072066f"
    instance_type = "t3.medium"
    key_name = "ganana-aws-master"
    availability_zone = "us-east-1a"
    tenancy = "default"
    subnet_id = "subnet-01683a1daaf141d72"
    ebs_optimized = false
    vpc_security_group_ids = [
        "sg-0c1b252e2c9eab9d2"
    ]
    source_dest_check = true
    root_block_device {
        volume_size = 10
        volume_type = "gp2"
        delete_on_termination = true
    }
    tags = {
        Name = "RE-POC-Bastion-EC2"
    }
}
