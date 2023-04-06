region = "ap-south-1"
ec2 = {
    instance_type = "t2.micro"
    key_name      = "chaitanyaimportkey"
    user_data     = ["apache2.sh", "nginx.sh"]
    port          = 80
    Name          = ["db1", "db2"]
  }