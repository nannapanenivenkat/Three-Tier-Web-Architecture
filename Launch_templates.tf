############################################## Private_instance_Launch_templates ###############################################################
# Launch Template Resource
resource "aws_launch_template" "private_web_app_instance_template" {
  name = "private_web_app_instance_template"
  description = "private_web_app_instance_template"
  image_id = aws_ami_from_instance.private_instance_ami.id
  instance_type = "t2.micro"
  key_name = "mynewkey"  
  ebs_optimized = true
  iam_instance_profile {
    name = aws_iam_role.Three_tier_Instance_role.arn
    
  }
  network_interfaces {
    device_index = 0
    associate_public_ip_address = false
    delete_on_termination = true
    security_groups = [aws_security_group.private_instance_sg.id]
  
  }
  #default_version = 1
  update_default_version = true
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 10 
      #volume_size = 20 # LT Update Testing - Version 2 of LT      
      delete_on_termination = true
      volume_type = "gp2" # default is gp2
     }
  }
  monitoring {
    enabled = false
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "public_instance_template"
    }
  }
}


############################################## Public_instance_Launch_templates ###############################################################
# Launch Template Resource
resource "aws_launch_template" "public_instance_template" {
  name = "public_instance_template"
  description = "public_instance_template"
  image_id = aws_ami_from_instance.public_instance_ami.id
  instance_type = "t2.micro"
  key_name = "mynewkey"  
  ebs_optimized = true
  iam_instance_profile {
    name = aws_iam_role.Three_tier_Instance_role.arn
    
  }
  network_interfaces {
    device_index = 0
    associate_public_ip_address = true
    delete_on_termination = true
    security_groups = [aws_default_security_group.web_sg_public.id]
  
  }
  #default_version = 1
  update_default_version = true
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 10 
      #volume_size = 20 # LT Update Testing - Version 2 of LT      
      delete_on_termination = true
      volume_type = "gp2" # default is gp2
     }
  }
  monitoring {
    enabled = false
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "public_instance_template"
    }
  }
}