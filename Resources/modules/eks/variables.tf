variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "region" {
  description = "Region of the EKS cluster"
  type        = string
}

variable "capacity_type" {    
  description = "Capacity type for the EKS cluster"
  type        = string
  default     = "ON_DEMAND"
}

variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 2
}

variable "authentication_mode" {
  description = "Authentication mode for the EKS cluster"
  type        = string
  default     = "API_AND_CONFIG_MAP"
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
}

variable "instance_type" {
  description = "EC2 instance type for the worker nodes"
  type        = string
}

variable "disk_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 20
}

variable "ami_release_version" {
  description = "AMI release version for the worker nodes (optional - EKS will choose appropriate version if not specified)"
  type        = string
  default     = null
}

variable "node_group_kubernetes_version" {
  description = "Kubernetes version for the node group"
  type        = string
}

variable "ami_type" {
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default     = {}
} 