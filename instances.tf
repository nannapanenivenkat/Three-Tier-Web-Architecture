#################################################### Public_Instance ##########################################################
resource "aws_instance" "public_instance" {
   count = 2
   ami             = "ami-00b8917ae86a424c9"
   instance_type   = "t2.micro"
   key_name       = "mynewkey"
   security_groups = [aws_default_security_group.default.id]
   subnet_id      = aws_subnet.public_subnet[count.index].id
   associate_public_ip_address=true

   tags = {
     Name = "public_instance"
   }
}


############################################### private_instance #############################################################

resource "aws_instance" "private_instance" {
   count = 2
   ami             = "ami-00b8917ae86a424c9"
   instance_type   = "t2.micro"
   key_name       = "mynewkey"
   security_groups = [aws_default_security_group.default.id]
   subnet_id      = aws_subnet.Private_web_app_subnet[count.index].id
   associate_public_ip_address=false

   tags = {
     Name = "private_instance"
   }
}