resource "aws_subnet" "public_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id  # Make sure to replace with your VPC ID
  cidr_block              = "10.0.${count.index * 3}.0/24"
  availability_zone       = element(["us-east-1a", "us-east-1b"], count.index)
  map_public_ip_on_launch = true

     tags = {
     Name = "Public subnet-${count.index + 1}"
   }
}


resource "aws_subnet" "Private_web_app_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id  # Make sure to replace with your VPC ID
  cidr_block              = "10.0.${count.index * 3 + 1}.0/24"
  availability_zone       = element(["us-east-1a", "us-east-1b"], count.index)
  map_public_ip_on_launch = true


     tags = {
     Name = "Private_web_app_subnet-${count.index + 1}"
   }
}


resource "aws_subnet" "Private_DB_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id  # Make sure to replace with your VPC ID
  cidr_block              = "10.0.${count.index * 3 + 2}.0/24"
  availability_zone       = element(["us-east-1a", "us-east-1b"], count.index)
  map_public_ip_on_launch = true

     tags = {
     Name = "Private_DB_subnet-${count.index + 1}"
   }
}