provider "aws" {
  region = var.region
}

provider "time" {}


module "elasticache_redis" {
  source = "./modules/elasticache-redis"

  replication_group_id          = "zad-redis-dev"
  replication_group_description = " "
  node_type                     = "cache.t4g.medium"
  engine                        = "redis"
  engine_version                = "6.2"
  parameter_group_name          = "default.redis6.x"
  subnet_group_name             = "subnet-for-redis"
  subnet_group_description      = ""
  secret_name                   = null
  replicas_per_node_group       = 1
  num_node_groups               = 1
  automatic_failover_enabled    = true
  multi_az_enabled              = true
  at_rest_encryption_enabled    = false
  data_tiering_enabled          = false
  transit_encryption_enabled    = false
  transit_encryption_mode       = "preferred"
  preferred_maintenance_window  = "wed:00:30-wed:01:30"
  auto_minor_version_upgrade    = true
  snapshot_retention_limit      = 1
  snapshot_window               = "04:00-05:00"
  log_retention_days            = 1
}


module "eks" {
  source = "./modules/eks"

  cluster_name                  = "zad-eks-dev"
  kubernetes_version            = "1.30"
  node_group_name               = "zad-node-group-dev2"
  capacity_type                 = "ON_DEMAND"
  authentication_mode           = "API_AND_CONFIG_MAP"
  desired_size                  = 2
  min_size                      = 2
  max_size                      = 2
  instance_type                 = "t3a.xlarge"
  disk_size                     = 20
  node_group_kubernetes_version = "1.29"
  ami_type                      = "AL2_x86_64"
  region                        = var.region

  tags = {
    Environment = "dev"
    Project     = "zad-eks"
    Name        = "zad-eks-dev"
  }
}