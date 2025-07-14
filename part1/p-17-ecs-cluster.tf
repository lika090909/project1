module "ecs_cluster" {
  source  =  "terraform-aws-modules/ecs/aws"
  version = "6.0.5"

  name                = "${var.environment}-my-ecs"
  vpc_id              = module.vpc.vpc_id
  public_subnets      = module.vpc.public_subnets
  private_subnets     = module.vpc.private_subnets

  enable_ecs_managed_tags = true
  enable_execute_command  = true

  create_ecs_cluster = true
  asg_desired_capacity = 2
  instance_type = "t3.medium"
  key_name = var.instance_keypair

  ecs_service = {
    myapp = {
      name                = "${var.environment}-myapp"
      task_cpu            = 256
      task_memory         = 512
      desired_count       = 2
      container_port      = 80
      docker_image        = var.docker_image
      alb_target_group_health_check_path = "/"
    }
  }
}
