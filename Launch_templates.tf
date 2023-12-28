############################################## Public_instance_Launch_templates ###############################################################
# Launch Template Resource
resource "aws_launch_template" "public_instance_template" {
  name = "public_instance_template"
  description = "public_instance_template"
  image_id = "ami-00b8917ae86a424c9"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_default_security_group.default.id]
  key_name = "mynewkey"  
  ebs_optimized = true
  network_interfaces {
    device_index = 0
    associate_public_ip_address = true
    delete_on_termination = true
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
resource "aws_launch_template" "private_instance_template" {
  name = "private_instance_template"
  description = "private_instance_template"
  image_id = "ami-00b8917ae86a424c9"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_default_security_group.default.id]
  key_name = "mynewkey"  
  ebs_optimized = true
  network_interfaces {
    device_index = 0
    associate_public_ip_address = false
    delete_on_termination = true
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
      Name = "private_instance_template"
    }
  }
}