###################################################### private_app_instance_target ########################################################
resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = true
  ip_address_type = "ipv4"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.internal_LB-SG.id]
  subnets            = [for subnet in aws_subnet.Private_web_app_subnet : subnet.id]

  tags = {
    Environment = "production"
  }
}


resource "aws_lb_target_group" "alb-example" {
  name        = "tf-example-lb-alb-tg"
  target_type = "instance"
  port        = 4000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  
  health_check {
    path      = "/health"
    port = "traffic-port"

  }
}



resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-example.arn
  }
}




###################################################### public_web_instance_target ########################################################

resource "aws_lb_target_group" "alb_tg_example_public" {
  name        = "alb-tg-example-public"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  
  health_check {
    path      = "/health"
    port = "traffic-port"

  }
}


resource "aws_lb" "alb_internet_facing_example_public" {
  name               = "alb-internet-facing-public"
  internal           = false
  ip_address_type = "ipv4"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.internet_facing_sg.id]
  subnets            = [for subnet in aws_subnet.public_subnet : subnet.id]

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "internet_facing_public_listner" {
  load_balancer_arn = aws_lb.alb_internet_facing_example_public.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_example_public.arn
  }
}