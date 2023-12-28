resource "aws_autoscaling_group" "example" {
  desired_capacity     = 2
  max_size             = 4
  min_size             = 1
  vpc_zone_identifier  = [aws_subnet.public_subnet[0].id, aws_subnet.public_subnet[1].id]  # Replace with your subnet IDs

  launch_template {
    id = aws_launch_template.private_instance_template.id
  }

  # Attach the Auto Scaling Group to the existing load balancer and target group
  health_check_type          = "ELB"
  health_check_grace_period  = 300

  tag {
    key                 = "Name"
    value               = "example-asg"
    propagate_at_launch = true
  }
}