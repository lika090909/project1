# Bastion Host 
module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.0"    
  # insert the 10 required variables here
  name                   = "BastionHost"
  #instance_count         = 5
  ami                    = data.aws_ami.ecs_optimized.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  #monitoring             = true
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.public_bastion_sg.security_group_id]
  tags = local.common_tags
}
