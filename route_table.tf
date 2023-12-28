resource "aws_default_route_table" "public" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.MyAWSInternet.id
    
  }
  tags = {
    Name = "example"
  }

}

resource "aws_route_table_association" "public_subnet_association" {
  count = length(aws_subnet.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_default_route_table.public.id

}




######################################################### private_route_table #######################################################



resource "aws_route_table" "private_web_app_route" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private"
  }
}

resource "aws_route_table_association" "private_web_app_subnet_association" {
  count = length(aws_subnet.Private_web_app_subnet)
  subnet_id      = aws_subnet.Private_web_app_subnet[count.index].id
  route_table_id = aws_route_table.private_web_app_route.id

}


resource "aws_route_table" "private_DB_route" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private"
  }
}

resource "aws_route_table_association" "private_DB_subnet_association" {
  count = length(aws_subnet.Private_DB_subnet)
  subnet_id      = aws_subnet.Private_DB_subnet[count.index].id
  route_table_id = aws_route_table.private_DB_route.id

}


resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private_web_app_route.id
    destination_cidr_block = "0.0.0.0/0"  # This assumes you want to route all traffic through the NAT gateway
    nat_gateway_id         = aws_nat_gateway.public_nat.id
  
}


resource "aws_route" "private_db_nat_gateway" {
  route_table_id         = aws_route_table.private_DB_route.id
    destination_cidr_block = "0.0.0.0/0"  # This assumes you want to route all traffic through the NAT gateway
    nat_gateway_id         = aws_nat_gateway.public_nat.id
  
}

