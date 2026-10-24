data "aws_ami" "instance" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = var.ami
  }
}

# data "aws_subnet" "selected" {
#   filter {
#     name   = "tag:Name"
#     values = ["yamaha-web-2"] #not recommended 
#   }
# }
data "aws_subnet" "selected" {
  id = "subnet-0fd8ff53a3cd933e1" #recommended 
}

resource "aws_instance" "webserver" {
  ami           = data.aws_ami.instance.id
  instance_type = var.machinetype
  key_name      = "yamaha-vpc"
  subnet_id     = data.aws_subnet.selected.id

  tags = {
    Name = "HelloWorld"
  }
}