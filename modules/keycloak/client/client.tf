terraform {
  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = "4.3.1"
    }
  }
}

resource "keycloak_openid_client" "client" {
  realm_id      = var.realm_id
  client_id     = var.client_id
  client_secret = var.client_secret
  name          = var.client_name
  enabled       = true
  access_type   = var.access_type
  login_theme   = var.login_theme

  service_accounts_enabled = var.is_client_credentials_grant
  standard_flow_enabled    = !var.is_client_credentials_grant

  valid_redirect_uris             = var.redirect_uris
  valid_post_logout_redirect_uris = var.post_logout_redirect_uri
  web_origins                     = var.web_origins

  dynamic "authentication_flow_binding_overrides" {
    for_each = var.browser_flow_id != null ? [1] : []
    content {
      browser_id = var.browser_flow_id
    }
  }

  access_token_lifespan      = var.access_token_lifespan_in_seconds
  pkce_code_challenge_method = var.pkce_code_challenge_method
}

resource "keycloak_openid_client_default_scopes" "default_scopes" {
  realm_id       = var.realm_id
  client_id      = keycloak_openid_client.client.id
  default_scopes = var.default_scopes
}

resource "keycloak_openid_client_optional_scopes" "optional_scopes" {
  realm_id        = var.realm_id
  client_id       = keycloak_openid_client.client.id
  optional_scopes = []
}

# Deprecated custom JWT claim
# https://jira.mercateo.lan/browse/ITD-87686
resource "keycloak_generic_protocol_mapper" "le_id_attribute_mapper_deprecated" {
  realm_id        = var.realm_id
  client_id       = keycloak_openid_client.client.id
  name            = "legal-entity-mapper-deprecated"
  protocol        = "openid-connect"
  protocol_mapper = "oidc-usermodel-attribute-mapper"
  config = {
    "user.attribute"       = "mercateo.legal_entity_id"
    "claim.name"           = "https://mercateo\\.com/.le_id"
    "id.token.claim"       = "true"
    "access.token.claim"   = "true"
    "userinfo.token.claim" = "true"
    "jsonType.label"       = "String"
  }
}

# Deprecated custom JWT claim
# https://jira.mercateo.lan/browse/ITD-87686
resource "keycloak_generic_protocol_mapper" "cm_id_attribute_mapper_deprecated" {
  realm_id        = var.realm_id
  client_id       = keycloak_openid_client.client.id
  name            = "character-mask-mapper-deprecated"
  protocol        = "openid-connect"
  protocol_mapper = "oidc-usermodel-attribute-mapper"
  config = {
    "user.attribute"       = "mercateo.character_mask_id"
    "claim.name"           = "https://mercateo\\.com/.cm_id"
    "id.token.claim"       = "true"
    "access.token.claim"   = "true"
    "userinfo.token.claim" = "true"
    "jsonType.label"       = "String"
  }
}

resource "keycloak_generic_protocol_mapper" "le_id_attribute_mapper" {
  realm_id        = var.realm_id
  client_id       = keycloak_openid_client.client.id
  name            = "legal-entity-mapper"
  protocol        = "openid-connect"
  protocol_mapper = "oidc-usermodel-attribute-mapper"
  config = {
    "user.attribute"       = "mercateo.legal_entity_id"
    "claim.name"           = "https://unite\\.eu/legalEntityId"
    "id.token.claim"       = "true"
    "access.token.claim"   = "true"
    "userinfo.token.claim" = "true"
    "jsonType.label"       = "String"
  }
}

resource "keycloak_generic_protocol_mapper" "cm_id_attribute_mapper" {
  realm_id        = var.realm_id
  client_id       = keycloak_openid_client.client.id
  name            = "character-mask-mapper"
  protocol        = "openid-connect"
  protocol_mapper = "oidc-usermodel-attribute-mapper"
  config = {
    "user.attribute"       = "mercateo.character_mask_id"
    "claim.name"           = "https://unite\\.eu/characterMaskId"
    "id.token.claim"       = "true"
    "access.token.claim"   = "true"
    "userinfo.token.claim" = "true"
    "jsonType.label"       = "String"
  }
}

