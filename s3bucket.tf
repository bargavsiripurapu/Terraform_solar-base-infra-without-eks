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

resource "aws_s3_bucket" "S3Bucket" {
    bucket = "businesszonebucketdemo1"
}

resource "aws_s3_bucket" "S3Bucket2" {
    bucket = "landingzonebucketdemo1"
}

resource "aws_s3_bucket" "S3Bucket3" {
    bucket = "cleanzonebucketdemo1"
}
