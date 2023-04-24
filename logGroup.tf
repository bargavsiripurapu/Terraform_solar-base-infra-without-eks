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

resource "aws_cloudwatch_log_group" "LogsLogGroup" {
    name = "Terra1-LogGroup-vrOKaScohy6h"
    retention_in_days = 7
}
