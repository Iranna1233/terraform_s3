provider "aws" {
  region     = "ap-south-1"
}

resource "aws_instance" "Demo" {
  ami       = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
  tags = {
    Name = "Demo"
  }
}
resource "aws_instance" "demo-server" {
 ami = "ami-09ba48996007c8b50"
 instance_type  = "t2.small"
}
