variable "region" {
  type    = string
  default = "ap-south-1"

}
variable "ec2" {
  type = map(object({
    instance_type = string
    key_name      = string
    user_data     = string
    port = number
  }))
  default = {
    "lb1" = {
      instance_type = "t2.micro"
      key_name      = "chaitanyaimportkey"
      user_data     = "apache2.sh" 
      port = 80
    }
    "lb2" = {
      instance_type = "t2.micro"
      key_name      = "chaitanyaimportkey"
      user_data     = "nginx.sh"
      port = 80
    }

  }

}
