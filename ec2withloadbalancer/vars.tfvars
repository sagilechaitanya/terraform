region = "ap-south-1"
ec2 = {
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