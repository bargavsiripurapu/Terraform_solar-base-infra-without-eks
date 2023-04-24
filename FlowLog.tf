resource "aws_flow_log" "example" {
  iam_role_arn = aws_iam_role.flowlogs.arn
  log_destination = aws_cloudwatch_log_group.flowlogs.arn
  traffic_type = !Ref TrafficType
  vpc_id = "${aws_vpc.EC2VPC.id}"
}

resource "aws_iam_role" "flowlogs" {
  name = "flowlogs"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_cloudwatch_log_group" "flowlogs" {
  name = "/aws/vpc/flowlogs/example"
  retention_in_days = 7
}

