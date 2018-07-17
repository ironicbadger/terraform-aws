# terraform-aws

Useful to quickly spin up some test droplets on AWS.

### Configure provider

Full docs [here](https://www.terraform.io/docs/providers/aws/index.html).

Generate a set of access keys in the AWS console and if you'd like to ENV vars you can do so thus:

    # Configure the AWS Provider
    provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "us-east-1"
    }

Alternatively a shared credentials file (in clear text on disk!) can be specified thus:

    provider "aws" {
    region                  = "eu-west-1"
    shared_credentials_file = "/home/user/.aws/creds"
    }

Note if you have performed `aws configure` you have most likely already got a plain text file on disk with this information under `~/.aws/credentials`. Unless, you're using IAM roles of course - which you should be.

### Dynamic Inventory (for Ansible)

Once created if you'd like run Ansible against these hosts (separately from TF) then you can use the included `ec2.py` script in the `aws-ansible-dynamic-inventory` folder.

    [alex@neo terraform-aws]$ ansible-console -u ec2-user -i aws-ansible-dynamic-inventory/ -b
        Welcome to the ansible console.
        Type help or ? to list commands.

        ec2-user@all (3)[f:5]# ping
        34.253.216.159 | SUCCESS => {
            "changed": false,
            "ping": "pong"
        }
        34.250.188.249 | SUCCESS => {
            "changed": false,
            "ping": "pong"
        }
        34.241.194.55 | SUCCESS => {
            "changed": false,
            "ping": "pong"
        }


If you'd like to avoid specifying a key pair everytime you run Ansible, the following snippet in your `~/.ssh/config` will help.

    Host 34.*
      IdentityFile ~/.ssh/neo.pem
      User ec2-user
