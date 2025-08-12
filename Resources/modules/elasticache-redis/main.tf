data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  name   = "default"
}
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name        = var.subnet_group_name
  subnet_ids  = slice(data.aws_subnets.default.ids, 0, 2)
  description = var.subnet_group_description
}

# Redis Replication Group (Cluster)
resource "aws_elasticache_replication_group" "redis_cluster" {
  replication_group_id = var.replication_group_id
  description          = var.replication_group_description
  node_type            = var.node_type
  port                 = var.port
  parameter_group_name = var.parameter_group_name
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids   = [data.aws_security_group.default.id]

  num_cache_clusters = var.num_node_groups * (var.replicas_per_node_group + 1)

  automatic_failover_enabled = var.automatic_failover_enabled
  multi_az_enabled           = var.multi_az_enabled

  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled
  transit_encryption_mode    = var.transit_encryption_mode

  auth_token = var.secret_name != null ? jsondecode(aws_secretsmanager_secret_version.redis_auth_token[0].secret_string).redis_password : null

  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  maintenance_window         = var.preferred_maintenance_window

  snapshot_retention_limit = var.snapshot_retention_limit
  snapshot_window          = var.snapshot_window

  engine         = var.engine
  engine_version = var.engine_version

  network_type = var.network_type
  ip_discovery = var.ip_discovery

  data_tiering_enabled = var.data_tiering_enabled

  depends_on = [
    aws_elasticache_subnet_group.redis_subnet_group,
  ]
}