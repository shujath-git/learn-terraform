
resource "aws_instance" "web" {
  ami           = "ami-0277155c3f0ab2930"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-007f219ec7fbc04b5"]
  tags = {
    Name = "HelloWorld"
  }
}