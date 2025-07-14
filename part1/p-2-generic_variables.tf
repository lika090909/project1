variable "aws_region" {
  description = "AWS region"
  type = string
  default = "us-east-1"
}

# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "dev"
}