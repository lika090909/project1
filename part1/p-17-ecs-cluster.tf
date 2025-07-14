module "ecs_cluster" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "6.0.0"

  cluster_name = "${var.environment}-ecs-cluster"

  }

# ECS Services Module" 


module "ecs_service" {
  source  = "terraform-aws-modules/ecs/aws//modules/service"
  version = "6.0.0"

  name        = "${var.environment}-myapp"
  cluster_arn = module.ecs_cluster.arn

  requires_compatibilities = ["EC2"]  # use EC2 launch type

  subnet_ids = module.vpc.private_subnets

  security_group_ingress_rules = {
    http = {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  container_definitions = {
    myapp = {
      image = var.docker_image       # your Docker image URI
      cpu   = 256
      memory = 512

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80   # important for EC2 launch type
          protocol      = "tcp"
        }
      ]
    }
  }

  desired_count = 2

  tags = {
    Environment = var.environment
  }
}
