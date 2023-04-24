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

resource "aws_vpc" "EC2VPC" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    instance_tenancy = "default"
    tags = {
        Name = "RE-POC"
    }
}

resource "aws_internet_gateway" "EC2InternetGateway" {
    tags = {
        Name = "RE-POC-IGW"
    }
    vpc_id = "${aws_vpc.EC2VPC.id}"
}

resource "aws_subnet" "EC2Subnet" {
    availability_zone = "us-east-1b"
    cidr_block = "10.0.12.0/24"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    map_public_ip_on_launch = false
}

resource "aws_subnet" "EC2Subnet2" {
    availability_zone = "us-east-1b"
    cidr_block = "10.0.2.0/24"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "EC2Subnet3" {
    availability_zone = "us-east-1a"
    cidr_block = "10.0.1.0/24"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "EC2Subnet4" {
    availability_zone = "us-east-1a"
    cidr_block = "10.0.11.0/24"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    map_public_ip_on_launch = false
}

resource "aws_route_table" "EC2RouteTable" {
    vpc_id = "${aws_vpc.EC2VPC.id}"
    tags = {
        Name = "RE-POC Public Routes"
    }
}

resource "aws_route_table" "EC2RouteTable2" {
    vpc_id = "${aws_vpc.EC2VPC.id}"
    tags = {}
}

resource "aws_route_table" "EC2RouteTable3" {
    vpc_id = "${aws_vpc.EC2VPC.id}"
    tags = {
        Name = "Private"
    }
}

resource "aws_nat_gateway" "EC2NatGateway" {
    subnet_id = "subnet-01683a1daaf141d72"
    tags = {}
    allocation_id = "eipalloc-057ff9268d5246ebb"
}

resource "aws_vpc_endpoint" "EC2VPCEndpoint" {
    vpc_endpoint_type = "Gateway"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    service_name = "com.amazonaws.us-east-1.s3"
    policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":\"*\",\"Action\":\"*\",\"Resource\":\"*\"}]}"
    route_table_ids = [
        "rtb-060006f41cd0d810e",
        "rtb-022a3445d9528dc8a"
    ]
    private_dns_enabled = false
}

resource "aws_security_group" "EC2SecurityGroup" {
    description = "Enable SSH from 0.0.0.0/0"
    name = "Terra1-BastionSecurityGroup-NV1UFJTFZQ5T"
    tags = {}
    vpc_id = "${aws_vpc.EC2VPC.id}"
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 22
        protocol = "tcp"
        to_port = 22
    }
    egress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
}
