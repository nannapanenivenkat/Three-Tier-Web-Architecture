resource "aws_security_group" "internet_facing_sg" {
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["35.146.201.142/32"]
  }


  tags = {
    Name = "internet_facing_sg"
  }
}

############################################## web_sg_public ##########################################################

resource "aws_default_security_group" "web_sg_public" {
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["35.146.201.142/32"]
  }

    ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_security_group.internet_facing_sg.id]
  }

  tags = {
    Name = "web_sg_public"
  }
}


############################################## internet_LB-SG ##########################################################

resource "aws_security_group" "internal_LB-SG" {
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_default_security_group.web_sg_public.id]
  }

  tags = {
    Name = "internet_LB-SG"
  }
}

############################################## private_instance_sg ##########################################################

resource "aws_security_group" "private_instance_sg" {
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Custom rule for port 4000 from My IP"
    from_port   = 4000
    to_port     = 4000
    protocol    = "tcp"
    cidr_blocks = ["35.146.201.142/32"]
  }

    ingress {
    description = "Custom rule for port 4000 from My IP"
    from_port   = 4000
    to_port     = 4000
    protocol    = "tcp"
    cidr_blocks = [aws_security_group.internal_LB-SG.id]
  }

  tags = {
    Name = "private_instance_sg"
  }
}

########################################################## database_sg ###################################################################
resource "aws_security_group" "database_sg" {
  name        = "rds_security_group"
  description = "Security group for RDS"
  vpc_id      = aws_vpc.main.id
  
  ingress {
    from_port   = 3306  # MySQL default port
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_security_group.private_instance_sg.id] # Allow traffic from any IP (adjust as needed)
  }

  tags = {
    Name = "database_sg"
  }
}