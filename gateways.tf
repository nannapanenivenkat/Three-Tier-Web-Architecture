resource "aws_internet_gateway" "MyAWSInternet" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "MyAWSInternet"
  }
}

################################### Elatic_IP ###############################################
resource "aws_eip" "ElasticIp1" {
    
}

################################### public_Nat_gateways ############################################
resource "aws_nat_gateway" "public_nat" {
  allocation_id = aws_eip.ElasticIp1.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "public_nat"
  }
}



################################# private_Nat_gateway ###############################################

