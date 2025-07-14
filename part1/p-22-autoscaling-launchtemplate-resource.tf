# Launch Template Resource
resource "aws_launch_template" "my_launch_template" {
  name_prefix = "${var.environment}-"
  description = "My Launch template"
  image_id = data.aws_ami.ecs_optimized.id
  instance_type = var.instance_type

  vpc_security_group_ids = [ module.private_sg.security_group_id ]
  key_name = var.instance_keypair
  user_data = base64encode(
    templatefile("${path.module}/ecs-agent.sh.tpl", {
    cluster_name = module.ecs_cluster.ecs_cluster_name
  })
)
  ebs_optimized = true 
  #default_version = 1
  update_default_version = true 
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 10      
      #volume_size = 20 # LT Update Testing - Version 2 of LT              
      delete_on_termination = true
      volume_type = "gp2" # default  is gp2 
    }
   }
  monitoring {
    enabled = true
  }   
  tag_specifications {
    resource_type = "instance"
    tags = local.common_tags
  }  
  
}

