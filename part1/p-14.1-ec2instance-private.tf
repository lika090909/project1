module "ec2_private" {
  depends_on = [ module.vpc ]
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.0"

  name                   = "${var.environment}-private_ec2-${each.key}"
  ami                    = data.aws_ami.ecs_optimized.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair

  user_data = base64encode(
  templatefile("${path.module}/ecs-agent.sh.tpl", {
    cluster_name = aws_ecs_cluster.main.name
  })
)

  for_each = toset(["0", "1"])
  subnet_id = element(module.vpc.private_subnets, tonumber(each.key))
  vpc_security_group_ids = [module.private_sg.security_group_id]

  tags = local.common_tags
}
