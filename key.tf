resource "aws_key_pair" "mykeypair" {
  key_name   = "ganana-aws-master"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}
