variable "region" {
  type    = string
  default = "ap-south-1"
}
variable "subnetinformation" {
  type = object({
    cidr        = list(string),
    subnetnames = list(string),
    subnetnames1 = list(string),
    subnetaz    = list(string)
  })
  default = {
    cidr        = ["10.0.0.0/16","192.168.0.0/16"]
    subnetnames = ["main1", "main2", "main3", "main4", "main5", "main6"]
    subnetnames1 = ["main7", "main8", "main9", "main10", "main11", "main12"]
    subnetaz    = ["a", "b", "c", "a", "b", "c"]
  }
}
variable "vpcinformation" {
  type = object({
    vpcnames = list(string)
  })
  default = {
    vpcnames = ["main", "main1"]
  }

}