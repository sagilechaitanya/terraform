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
resource "aws_instance" "web" {
  count                       = length(var.ec2.Name)
  ami                         = data.aws_ami_ids.ubuntu_2204.ids[0]
  instance_type               = var.ec2.instance_type
  associate_public_ip_address = true
  key_name                    = var.ec2.key_name
  subnet_id                   = data.aws_subnets.default.ids[0]
  vpc_security_group_ids      = [data.aws_security_group.name.id]
  tags = {
    "Name" = var.ec2.Name[count.index]
  }
}
resource "null_resource" "web" {
  triggers = {
    instance_ids = 0
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = aws_instance.web[0].public_ip
  }
#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt update",
#       "sudo apt install apache2 -y",
#     ]
#   }
provisioner "file" {
    source      = "apache2.sh"
    destination = "/tmp/apache2.sh"
  }
  provisioner "remote-exec" {
     inline = [
     "sh /tmp/apache2.sh"
     ]
   }
}
resource "null_resource" "web2" {
  triggers = {
    instance_ids = 1
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = aws_instance.web[1].public_ip
  }
#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt update",
#       "sudo apt install nginx -y",
#     ]
#   }
  provisioner "file" {
    source      = "nginx.sh"
    destination = "/tmp/nginx.sh"
  }
  provisioner "remote-exec" {
     inline = [
     "sh /tmp/nginx.sh"
     ]
   }
}
resource "aws_lb_target_group" "test" {
  name        = "test"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.default.id
}
resource "aws_lb_target_group_attachment" "test" {
  count            = length(var.ec2.Name)
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = aws_instance.web[count.index].id
  port             = var.ec2.port
  depends_on = [
    aws_instance.web,
    aws_lb_target_group.test
  ]
}
resource "aws_lb" "test" {
  name               = "test-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.name.id]
  subnets            = [data.aws_subnets.default.ids[0], data.aws_subnets.default.ids[1]]
  depends_on = [
    aws_instance.web,
    aws_lb_target_group.test,
    aws_lb_target_group_attachment.test
  ]
  # inthe place of subnets we can also use subnet mapping
  #sunet_mapping{
  #   subnet_id = data.aws_subnets.default,ids[0]
  # }
  #sunet_mapping{
  #   subnet_id = data.aws_subnets.default,ids[1]
  # }
}
resource "aws_lb_listener" "target" {
  load_balancer_arn = aws_lb.test.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}



