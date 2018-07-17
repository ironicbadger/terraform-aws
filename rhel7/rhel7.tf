provider "aws" {
    region = "eu-west-1"
    shared_credentials_file = "/home/alex/.aws/credentials"
}

data "aws_ami" "rhel7_ami" {
    most_recent = true

    filter {
        name = "name"
        values = ["RHEL-7.*_HVM_GA*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["309956199498"] # red hat
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }    
}

resource "aws_instance" "rhel7" {
    count = 3

    ami = "${data.aws_ami.rhel7_ami.id}"
    instance_type = "t2.micro"
    key_name = "neo"
    vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]

    tags {
        Name = "TEST-${count.index + 1}"
        role = "rabbitmq"
    }
}