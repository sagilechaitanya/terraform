output "vpc_id" {
  value = data.aws_vpc.default.id

}
output "aws_subnets" {
  value = data.aws_subnets.default.ids

}
output "aws_security_group" {
  value = data.aws_security_group.name.id
}
output "aws_ami_ids" {
  value = data.aws_ami_ids.ubuntu_2204.ids

}
output "instanceid1" {
  value = aws_instance.web[0].id
}
output "instanceid2" {
  value = aws_instance.web[1].id
}
output "public_ip1" {
  value = aws_instance.web[0].public_ip

}
output "public_ip2" {
  value = aws_instance.web[1].public_ip

}
output "lb" {
  value = aws_lb.test.dns_name

}
