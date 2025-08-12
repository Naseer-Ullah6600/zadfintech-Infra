output "cluster_id" {
  description = "The ID of the EKS cluster"
  value       = aws_eks_cluster.main.id
}

output "cluster_arn" {
  description = "The ARN of the EKS cluster"
  value       = aws_eks_cluster.main.arn
}

output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_version" {
  description = "The Kubernetes version of the EKS cluster"
  value       = aws_eks_cluster.main.version
}

output "cluster_certificate_authority_data" {
  description = "The base64 encoded certificate data required to communicate with the cluster"
  value       = aws_eks_cluster.main.certificate_authority[0].data
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster for the OpenID Connect identity provider"
  value       = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

output "node_group_id" {
  description = "The ID of the EKS node group"
  value       = aws_eks_node_group.main.id
}

output "node_group_arn" {
  description = "The ARN of the EKS node group"
  value       = aws_eks_node_group.main.arn
}

output "node_group_name" {
  description = "The name of the EKS node group"
  value       = aws_eks_node_group.main.node_group_name
}

output "node_group_status" {
  description = "The status of the EKS node group"
  value       = aws_eks_node_group.main.status
}

output "cluster_role_arn" {
  description = "The ARN of the EKS cluster IAM role"
  value       = aws_iam_role.eks_cluster.arn
}

output "node_group_role_arn" {
  description = "The ARN of the EKS node group IAM role"
  value       = aws_iam_role.eks_node_group.arn
}

output "vpc_id" {
  description = "The ID of the VPC used by the EKS cluster"
  value       = data.aws_vpc.default.id
}

output "subnet_ids" {
  description = "The IDs of the subnets used by the EKS cluster"
  value       = slice(data.aws_subnets.eks_supported_subnets.ids, 0, 3)
}

# Addon Outputs
output "vpc_cni_addon_arn" {
  description = "The ARN of the VPC CNI addon"
  value       = aws_eks_addon.vpc_cni.arn
}

output "coredns_addon_arn" {
  description = "The ARN of the CoreDNS addon"
  value       = aws_eks_addon.coredns.arn
}

output "pod_identity_agent_addon_arn" {
  description = "The ARN of the EKS Pod Identity Agent addon"
  value       = aws_eks_addon.eks_pod_identity_agent.arn
}

output "ebs_csi_addon_arn" {
  description = "The ARN of the AWS EBS CSI Driver addon"
  value       = aws_eks_addon.aws_ebs_csi_driver.arn
}

output "cert_manager_addon_arn" {
  description = "The ARN of the Cert Manager addon"
  value       = aws_eks_addon.cert_manager.arn
}

output "efs_csi_addon_arn" {
  description = "The ARN of the AWS EFS CSI Driver addon"
  value       = aws_eks_addon.aws_efs_csi_driver.arn
}

# IAM Role Outputs for Pod Identity
output "vpc_cni_pod_identity_role_arn" {
  description = "The ARN of the VPC CNI pod identity IAM role"
  value       = aws_iam_role.vpc_cni_pod_identity_role.arn
}

output "ebs_csi_pod_identity_role_arn" {
  description = "The ARN of the EBS CSI pod identity IAM role"
  value       = aws_iam_role.ebs_csi_pod_identity_role.arn
}

output "efs_csi_pod_identity_role_arn" {
  description = "The ARN of the EFS CSI pod identity IAM role"
  value       = aws_iam_role.efs_csi_pod_identity_role.arn
} 