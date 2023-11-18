#resource "aws_ssm_parameter" "client_secret" {
#  count  = var.store_client_secret_in_ssm ? 1 : 0
#  name   = "/uv/keycloak/clients/${keycloak_openid_client.client.client_id}/secret"
#  type   = "SecureString"
#  value  = keycloak_openid_client.client.client_secret
#  key_id = "alias/uv/parameter-store/secrets"
#}