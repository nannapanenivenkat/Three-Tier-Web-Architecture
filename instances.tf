#################################################### Public_Instance ##########################################################
resource "aws_instance" "public_instance" {
   ami             = "ami-00b8917ae86a424c9"
   instance_type   = "t2.micro"
   key_name       = "mynewkey"
   security_groups = [aws_default_security_group.web_sg_public.id]
   subnet_id      = aws_subnet.public_subnet[0].id
   associate_public_ip_address=true
   iam_instance_profile = aws_iam_role.Three_tier_Instance_role.name
   

   tags = {
     Name = "public_instance"
   }
}

############################################## Creating an AMI of our public instance ###########################################################
resource "aws_ami_from_instance" "public_instance_ami" {
  name               = "MyPublicInstanceAMI"
  source_instance_id = aws_instance.public_instance.id
}





############################################### private_instance #############################################################

resource "aws_instance" "private_instance" {
   ami             = "ami-00b8917ae86a424c9"
   instance_type   = "t2.micro"
   key_name       = "mynewkey"
   security_groups = [aws_security_group.private_instance_sg.id]
   subnet_id      = aws_subnet.Private_web_app_subnet[0].id
   associate_public_ip_address=false
   iam_instance_profile = aws_iam_role.Three_tier_Instance_role.name
   

   tags = {
     Name = "private_instance"
   }
}

############################################## Creating an AMI of our private instance ###########################################################
resource "aws_ami_from_instance" "private_instance_ami" {
  name               = "MyPrivateInstanceAMI"
  source_instance_id = aws_instance.private_instance.id
}


