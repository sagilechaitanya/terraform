variable "region" {
  type    = string
  default = "ap-south-1"
}
variable "ec2" {
  type = object({
    ami           = string,
    instance_type = string,
    volume_size   = string,
    key_name      = string

  })
  default = {
    ami           = "ami-02eb7a4783e7e9317"
    instance_type = "t2.micro"
    volume_size   = "8"
    key_name      = "chaitanyaimportkey"

  }

}
