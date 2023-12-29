resource "aws_internet_gateway" "MyAWSInternet" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "MyAWSInternet"
  }
}

################################### Elatic_IP ###############################################
resource "aws_eip" "ElasticIp1" {
    
}

resource "aws_eip" "ElasticIp2" {
    
}

################################### public_Nat_gateways ############################################
resource "aws_nat_gateway" "public_nat1" {
  allocation_id = aws_eip.ElasticIp1.id
  subnet_id     = aws_subnet.public_subnet[0].id
  connectivity_type = "public"

  tags = {
    Name = "public_nat1"
  }
}

resource "aws_nat_gateway" "public_nat2" {
  allocation_id = aws_eip.ElasticIp2.id
  subnet_id     = aws_subnet.public_subnet[1].id
  connectivity_type = "public"

  tags = {
    Name = "public_nat2"
  }
}


################################# private_Nat_gateway ###############################################

