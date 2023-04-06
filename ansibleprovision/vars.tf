variable "region" {
  type    = string
  default = "ap-south-1"

}
variable "ec2" {
  type = object({
    instance_type = string
    key_name      = string
  })
  default = {
    instance_type = "t2.micro"
    key_name      = "chaitanyaimportkey"
  }

}