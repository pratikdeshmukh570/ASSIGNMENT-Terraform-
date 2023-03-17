# Provider Configuration
resource "aws_key_pair" "key" {
  key_name   = "pratik"
  public_key = file("~/.ssh/aws.pub")
}

resource "aws_default_vpc" "default_vpc" {

}
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"

  # using default VPC
  vpc_id      = aws_default_vpc.default_vpc.id

  ingress {
    description = "TLS from VPC"

    # we should allow incoming and outoging
    # TCP packets
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    # allow all traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}
resource "aws_instance" "ec2_instance" {
  ami             = var.ami_id
  instance_type   = "t2.micro"

  # refering key which we created earlier
  key_name        = aws_key_pair.key.key_name

  # refering security group created earlier
  security_groups = [aws_security_group.allow_ssh.name]

  tags = var.tags
}


variable "ami_id" {
  description = "Ubuntu ami id"

  # Amazon linux image
  default     = "ami-0caf778a172362f1c"
}

variable "tags" {
  type = map(string)
  default = {
    "name" = "My EC2 Instance"
  }
}
output "arn" {
  value = aws_instance.ec2_instance.arn
}

output "public_ip" {
  value = aws_instance.ec2_instance.public_ip
}
