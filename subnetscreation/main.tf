resource "aws_vpc" "vpcs" {
  cidr_block = var.subnetinformation.cidr[count.index]
  count      = length(var.vpcinformation.vpcnames)
  tags = {
    Name = var.vpcinformation.vpcnames[count.index]
  }
}
resource "aws_subnet" "subnets" {
  vpc_id            = aws_vpc.vpcs[0].id
  count             = length(var.subnetinformation.subnetnames)
  cidr_block        = cidrsubnet(var.subnetinformation.cidr[0], 8, count.index)
  availability_zone = "${var.region}${var.subnetinformation.subnetaz[count.index]}"
  depends_on = [
   aws_vpc.vpcs[0]
  ]
  tags = {

    Name = var.subnetinformation.subnetnames[count.index]
  }
}
resource "aws_subnet" "subnets1" {
  vpc_id            = aws_vpc.vpcs[1].id
  count             = length(var.subnetinformation.subnetnames1)
  cidr_block        = cidrsubnet(var.subnetinformation.cidr[1], 8, count.index)
  availability_zone = "${var.region}${var.subnetinformation.subnetaz[count.index]}"
  depends_on = [
   aws_vpc.vpcs[1]
  ]
  tags = {
    Name = var.subnetinformation.subnetnames1[count.index]
  }
}

