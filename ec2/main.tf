data "aws_ami_ids" "ubuntu_2204" {
  owners = ["099720109477"]
  filter {
    name   = "description"
    values = ["Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2023-02-08"]
  }
  filter {
    name   = "is-public"
    values = ["true"]
  }
}
resource "aws_instance" "ec2" {
  ami           = data.aws_ami_ids.ubuntu_2204.ids[0]
  instance_type = var.ec2.instance_type
  key_name      = var.ec2.key_name
  root_block_device {
    volume_size = var.ec2.volume_size
  }
  associate_public_ip_address = true
}
# resource "aws_s3_bucket" "b" {
#   bucket = "my-tt-test-bucket"
#   acl    = "private"
#   versioning {
#     enabled = true
#   }

# }
# resource "aws_s3_bucket_acl" "example" {
#   bucket = aws_s3_bucket.b.id
#   acl    = "private"
# }
# resource "aws_dynamodb_table" "dynamodb-table" {
#   name           = "dynamodb-table"
#   read_capacity  = 2
#   write_capacity = 2
#   hash_key       = "LockId"
#    attribute {
#     name = "LockId"
#     type = "S"
#    }
# }
# terraform {
#   backend "s3" {
#     bucket = "my-tt-test-bucket"
#     key    = "terraform.tfstate"
#     dynamodb_table = "dynamodb-table"
#     region = "ap-south-1"
#     }

#   }


