module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "6.0.0" 

  name               = "alb"
  load_balancer_type = "application"
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets
  security_groups    = [module.loadbalancer_sg.security_group_id]

  # HTTP Listener - Redirect to HTTPS
  http_tcp_listeners = [
    {
      port         = 80
      protocol     = "HTTP"
      action_type  = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

  # Target Groups (for ECS)
  target_groups = [
    {
      name_prefix          = "app1-"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "ip"                        # ECS-style target
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"                        # or your app health path
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version    = "HTTP1"
      create_attachment   = false                        # ECS will attach automatically
    }
  ]

  # HTTPS Listener
  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = module.acm.acm_certificate_arn
      action_type        = "forward"
      target_group_index = 0
    }
  ]

  # HTTPS Listener Rules (for path-based routing)
  https_listener_rules = [
    {
      https_listener_index = 0
      priority             = 1
      actions = [
        {
          type               = "forward"
          target_group_index = 0
        }
      ]
    }
  ]

  tags = local.common_tags
}
