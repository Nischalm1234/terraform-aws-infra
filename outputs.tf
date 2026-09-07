output "vpc_id" {
  description = "VPC ID"
  value       = module.networking.vpc_id
}

output "web_server_public_ip" {
  description = "Web server public IP — open this in your browser"
  value       = module.compute.web_public_ip
}

output "web_server_public_dns" {
  description = "Web server public DNS"
  value       = module.compute.web_public_dns
}

output "app_server_private_ip" {
  description = "App server private IP"
  value       = module.compute.app_private_ip
}

output "s3_bucket_name" {
  description = "S3 app storage bucket"
  value       = module.storage.bucket_name
}

output "ami_used" {
  description = "Ubuntu AMI used for EC2 instances"
  value       = module.compute.ami_id_used
}