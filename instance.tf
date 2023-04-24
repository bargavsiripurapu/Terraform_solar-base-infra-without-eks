resource "aws_instance" "EC2Instance" {
    ami = "ami-0742b4e673072066f"
    instance_type = "t3.medium"
    key_name = "ganana-aws-master"
    availability_zone = "us-east-1a"
    tenancy = "default"
    subnet_id = aws_subnet.EC2Subnet3.id
    ebs_optimized = false
    vpc_security_group_ids = [
        aws_security_group.EC2SecurityGroup.id
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
