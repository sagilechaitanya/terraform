variable "region" {
  type    = string
  default = "ap-south-1"

}
variable "ec2" {
  type = object({
    instance_type = string
    key_name      = string
    user_data     = list(string)
    port          = number
    Name          = list(string)
  })
  default = {
    instance_type = "t2.micro"
    key_name      = "chaitanyaimportkey"
    user_data     = ["apache2.sh", "nginx.sh"]
    port          = 80
    Name          = ["db1", "db2"]
  }

}


