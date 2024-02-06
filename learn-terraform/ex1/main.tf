
resource "aws_instance" "web" {
  ami           = "ami-0277155c3f0ab2930"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sgr-03a29df0a6097d159"]
  tags = {
    Name = "HelloWorld"
  }
}
