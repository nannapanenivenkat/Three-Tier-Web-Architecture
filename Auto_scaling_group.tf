resource "aws_autoscaling_group" "private_web_app_scaling" {
  name = "private-web-app-scaling"
  desired_capacity     = 2
  max_size             = 4
  min_size             = 2
  vpc_zone_identifier  = [aws_subnet.Private_web_app_subnet[0].id, aws_subnet.Private_web_app_subnet[1].id]  # Replace with your subnet IDs
  target_group_arns = [aws_lb_target_group.alb-example.arn]

  launch_template  {
    id = aws_launch_template.private_web_app_instance_template.id
  }
  
  # Attach the Auto Scaling Group to the existing load balancer and target group
  health_check_type          = "EC2"
  health_check_grace_period  = 300
  force_delete               = true
  wait_for_capacity_timeout  = "0"
  

  tag {
    key                 = "Name"
    value               = "private-web-app-scaling"
    propagate_at_launch = true
  }
  
}

################################################################## public_auto_scaling ##########################################################

resource "aws_autoscaling_group" "public_scaling" {
  name = "public-scaling"
  desired_capacity     = 2
  max_size             = 2
  min_size             = 2
  vpc_zone_identifier  = [aws_subnet.public_subnet[0].id, aws_subnet.public_subnet[1].id]  # Replace with your subnet IDs
  target_group_arns = [aws_lb_target_group.alb_tg_example_public.arn]

  launch_template {
   id = aws_launch_template.public_instance_template.id
  }
  
  # Attach the Auto Scaling Group to the existing load balancer and target group
  health_check_type          = "EC2"
  health_check_grace_period  = 300
  force_delete               = true
  wait_for_capacity_timeout  = "0"
  

  tag {
    key                 = "Name"
    value               = "public_scaling"
    propagate_at_launch = true
  }
  
}