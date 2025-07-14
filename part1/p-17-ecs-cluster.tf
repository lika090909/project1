module "ecs_cluster" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "5.6.0"

  name                = "${var.environment}-ecs-cluster"
  vpc_id              = module.vpc.vpc_id
  subnets             = module.vpc.private_subnets
  asg_desired_capacity = 2
  instance_type        = "t3.medium"
  key_name             = var.instance_keypair
  enable_ecs_managed_tags = true
  enable_execute_command  = true

  services = {
    myapp = {
      name             = "${var.environment}-myapp"
      desired_count    = 2
      task_cpu         = 256
      task_memory      = 512
      container_port   = 80
      docker_image     = var.docker_image
      alb_target_group_health_check_path = "/"
    }
  }
}
