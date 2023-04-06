variable "region" {
  type    = string
  default = "ap-south-1"

}
variable "ec2" {
  type = object({
    instance_type = string
    key_name      = string
    user_data1    = string
    user_data2    = string
  })
  default = {
    instance_type = "t2.micro"
    key_name      = "chaitanyaimportkey"
    user_data1    = "ansible.sh"
    user_data2    = "onetoten.sh"
  }


}
