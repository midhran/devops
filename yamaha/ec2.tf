resource "aws_instance" "ec2_web" {
  ami = var.ami_name
  instance_type   = var.instance_type
  key_name        = "yamaha-vpc"
  security_groups = ["yamaha_sg"]
  tags = {
    Name        = var.tag_name
    Environment = "dev"
  }

}