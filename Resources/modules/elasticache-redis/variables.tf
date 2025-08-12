variable "replication_group_id" {
  description = "The replication group identifier"
  type        = string
}

variable "replication_group_description" {
  description = "The description of the replication group"
  type        = string
}

variable "node_type" {
  description = "The compute and memory capacity of the nodes"
  type        = string
}

variable "port" {
  description = "The port number on which each of the nodes accepts connections"
  type        = number
  default     = 6379
}

variable "parameter_group_name" {
  description = "The name of the parameter group to associate with this replication group"
  type        = string
}

variable "subnet_group_name" {
  description = "The name of the cache subnet group"
  type        = string
}

variable "subnet_group_description" {
  description = "The description of the cache subnet group"
  type        = string
}


variable "replicas_per_node_group" {
  description = "Number of replica nodes in each node group"
  type        = number
}

variable "num_node_groups" {
  description = "Number of node groups (shards) for the cluster"
  type        = number
}

variable "automatic_failover_enabled" {
  description = "Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails"
  type        = bool
  default     = true
}

variable "multi_az_enabled" {
  description = "Specifies whether to enable Multi-AZ Support for the replication group"
  type        = bool
  default     = true
}

variable "at_rest_encryption_enabled" {
  description = "Whether to enable encryption at rest"
  type        = bool
}

variable "transit_encryption_enabled" {
  description = "Whether to enable encryption in transit"
  type        = bool
}

variable "transit_encryption_mode" {
  description = "Transit encryption mode"
  type        = string
}


variable "preferred_maintenance_window" {
  description = "Specifies the weekly time range for when maintenance on the cache cluster is performed"
  type        = string
}

variable "auto_minor_version_upgrade" {
  description = "Specifies whether minor version engine upgrades are applied automatically to the underlying Cache Cluster instances"
  type        = bool
}

variable "snapshot_retention_limit" {
  description = "The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them"
  type        = number
}

variable "snapshot_window" {
  description = "Daily time range during which ElastiCache will take a snapshot of the cache cluster"
  type        = string
}

variable "engine" {
  description = "The name of the cache engine"
  type        = string
}

variable "engine_version" {
  description = "The version number of the cache engine"
  type        = string
}

variable "network_type" {
  description = "The IP version to advertise in the discovery protocol"
  type        = string
  default     = "ipv4"
}

variable "ip_discovery" {
  description = "The IP version to advertise in the discovery protocol"
  type        = string
  default     = "ipv4"
}

variable "data_tiering_enabled" {
  description = "Enables data tiering"
  type        = bool
}



variable "log_retention_days" {
  description = "Number of days to retain CloudWatch logs"
  type        = number
}


variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default     = {}
}

# variable "vpc_id" {
#   description = "The ID of the VPC to use for ElastiCache."
#   type        = string
# }

# variable "subnet_ids" {
#   description = "List of subnet IDs for ElastiCache."
#   type        = list(string)
# }

variable "secret_name" {
  description = "The name of the secret to store the Redis AUTH token"
  type        = string

}