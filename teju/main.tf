data "aws_vpc" "default" {
  default = true
}
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
data "aws_security_group" "name" {
  vpc_id = data.aws_vpc.default.id
  filter {
    name   = "tag-key"
    values = ["Name"]
  }
  filter {
    name   = "tag-value"
    values = ["chaitanya"]
  }
}
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
resource "aws_instance" "chaitanya" {
  ami               = data.aws_ami_ids.ubuntu_2204.ids[0]
  instance_type     = "t2.micro"
  key_name          = "chaitanyaimportkey"
  availability_zone = "ap-south-1a"
  security_groups   = [data.aws_security_group.name.name]
  tags = {
    "Name" = "chai"
  }
}
# resource "null_resource" "teju" {
#   triggers = {
#     null = 1
#   }
#   connection {
#     type        = "ssh"
#     user        = "ubuntu"
#     private_key = file("~/.ssh/id_rsa")
#     host        = aws_instance.chaitanya.public_ip
#   }
#   provisioner "file" {
#     source      = "./ansible.sh"
#     destination = "/tmp/ansible.sh"
#   }
#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /tmp/ansible.sh",
#       "/tmp/ansible.sh args"
#     ]
#   }
resource "null_resource" "null" {
    triggers = {
    instance = 1
  }
  connection {
    host        = aws_instance.chaitanya.public_ip
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    type        = "ssh"
  }
  provisioner "file" {
    source      = "ansible.sh"
    destination = "/tmp/ansible.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sh /tmp/ansible.sh"
    ]
  }
  depends_on = [
    aws_instance.chaitanya
  ]
}
