output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = module.ecs_cluster.ecs_cluster_name
}

output "ecs_cluster_id" {
  description = "ID of the ECS cluster"
  value       = module.ecs_cluster.ecs_cluster_id
}

output "ecs_service_name" {
  description = "ECS service name"
  value       = module.ecs_cluster.ecs_service["myapp"].name
}

output "ecs_task_definition_arn" {
  description = "Task definition ARN"
  value       = module.ecs_cluster.ecs_service["myapp"].task_definition
}

# output "autoscaling_group_name" {
#   description = "Name of the ASG (EC2 ECS instances)"
#   value       = module.ecs_cluster.autoscaling_group_name
# }

output "ecs_service_target_group_arn" {
  value = module.ecs_cluster.target_group_arns["myapp"]
}