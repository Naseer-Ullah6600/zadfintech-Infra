
output "replication_group_id" {
  description = "The ID of the ElastiCache Replication Group"
  value       = aws_elasticache_replication_group.redis_cluster.id
}

output "replication_group_arn" {
  description = "The ARN of the ElastiCache Replication Group"
  value       = aws_elasticache_replication_group.redis_cluster.arn
}

output "configuration_endpoint_address" {
  description = "The address of the configuration endpoint for this replication group"
  value       = aws_elasticache_replication_group.redis_cluster.configuration_endpoint_address
}

output "port" {
  description = "The port number for the Redis cluster"
  value       = var.port
}

output "primary_endpoint_address" {
  description = "The address of the endpoint for the primary node in this replication group"
  value       = aws_elasticache_replication_group.redis_cluster.primary_endpoint_address
}

output "reader_endpoint_address" {
  description = "The address of the endpoint for the reader node in this replication group"
  value       = aws_elasticache_replication_group.redis_cluster.reader_endpoint_address
}

output "member_clusters" {
  description = "The identifiers of all the nodes that are part of this replication group"
  value       = aws_elasticache_replication_group.redis_cluster.member_clusters
}

output "subnet_group_id" {
  description = "The ID of the ElastiCache Subnet Group"
  value       = aws_elasticache_subnet_group.redis_subnet_group.id
}

output "subnet_group_arn" {
  description = "The ARN of the ElastiCache Subnet Group"
  value       = aws_elasticache_subnet_group.redis_subnet_group.arn
}

output "security_group_id" {
  description = "The ID of the security group for the Redis cluster"
  value       = data.aws_security_group.default.id
}

# output "security_group_arn" {
#   description = "The ARN of the security group for the Redis cluster"
#   value       = data.aws_security_group.default.id.arn
# }

