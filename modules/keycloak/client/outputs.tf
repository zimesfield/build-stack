output "client_id" {
  value = var.client_id
}

output "id" {
  value = keycloak_openid_client.client.id
}

output "realm_id" {
  value = var.realm_id
}
