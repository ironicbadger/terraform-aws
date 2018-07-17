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

resource "aws_instance" "rhel7" {
    count = 3

    ami = "${data.aws_ami.rhel7_ami.id}"
    instance_type = "t2.micro"

    tags {
        Name = "TEST-${count.index + 1}"
        role = "rabbitmq"
    }
}
