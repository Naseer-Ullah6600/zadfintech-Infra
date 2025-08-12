# secret.tf

resource "random_password" "redis_auth_token" {
  # Add this line
  count = var.secret_name != null ? 1 : 0

  length  = 32
  special = false
}

resource "aws_secretsmanager_secret" "redis_auth_token" {
  # Add this line
  count = var.secret_name != null ? 1 : 0

  name = var.secret_name
}

resource "aws_secretsmanager_secret_version" "redis_auth_token" {
  # Add this line
  count = var.secret_name != null ? 1 : 0

  # Update this to use the count index [0]
  secret_id = aws_secretsmanager_secret.redis_auth_token[0].id

  secret_string = jsonencode({
    # Update this to use the count index [0]
    redis_password = random_password.redis_auth_token[0].result
  })
}