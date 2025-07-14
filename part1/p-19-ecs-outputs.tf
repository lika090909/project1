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

output "cluster_arn" {
  description = "ARN that identifies the cluster"
  value       = module.ecs_cluster.arn
}

output "cluster_capacity_providers" {
  description = "Map of cluster capacity providers attributes"
  value       = module.ecs_cluster.cluster_capacity_providers
}

output "cluster_autoscaling_capacity_providers" {
  description = "Map of capacity providers created and their attributes"
  value       = module.ecs_cluster.autoscaling_capacity_providers
}