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