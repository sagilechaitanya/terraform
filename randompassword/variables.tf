variable "region" {
  type    = string
  default = "ap-south-1"
}
variable "dbinstanceingo" {
  type = object({
    instancetype = string,
    engine       = string,
    username     = string,
    storage      = string,
  })
  default = {
    engine       = "mysql"
    instancetype = "db.t2.micro"
    storage      = "8"
    username     = "chaitanya"
  }
}