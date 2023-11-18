#locals {
#  upp_configs = {
#    local = {
#      access_token_lifespan_in_seconds = 36000
#      urls                             = ["http://localhost:8080"]
#    }
#    devstage = {
#      access_token_lifespan_in_seconds = 36000
#      urls                             = ["http://localhost:8080", "https://upp.devstage.unite.eu"]
#    }
#    minilive = {
#      access_token_lifespan_in_seconds = null
#      urls                             = ["https://upp.minilive.unite.eu"]
#    }
#    mercateo = {
#      access_token_lifespan_in_seconds = null
#      urls                             = ["https://upp.unite.eu"]
#    }
#  }
#  upp = local.upp_configs[var.account_name]
#}
#
#output "arkiva_client_id" {
#  value = module.client_arkiva.client_id
#}
#
#module "client_arkiva" {
#  source = "./client"
#
#  realm_id    = keycloak_realm.arkiva_realm.id
#  client_id   = "upp"
#  client_name = "Unite Procurement Portal"
#  access_type = "PUBLIC"
#
#  default_scopes = [
#    keycloak_openid_client_scope.arkiva_profile.name
#  ]
#
#  redirect_uris = [for url in local.upp.urls : format("%s/*", url)]
#  web_origins   = local.upp.urls
#
#  access_token_lifespan_in_seconds = local.upp.access_token_lifespan_in_seconds
#  pkce_code_challenge_method       = "S256"
##  browser_flow_id                  = keycloak_authentication_flow.terms_of_use_flow.id
#}
#
#resource "keycloak_generic_protocol_mapper" "upp_aud_open_id_attribute_mapper" {
#  realm_id        = module.client_arkiva.realm_id
#  client_id       = module.client_arkiva.id
#  name            = "audience-mapper"
#  protocol        = "openid-connect"
#  protocol_mapper = "oidc-audience-mapper"
#  config = {
#    "included.custom.audience" : "https://upp.unite.eu"
#    "id.token.claim"     = "true"
#    "access.token.claim" = "true"
#  }
#}
#
#
#resource "keycloak_generic_protocol_mapper" "arkiva_legacy_token_open_id_attribute_mapper" {
#  realm_id        = module.client_arkiva.realm_id
#  client_id       = module.client_arkiva.id
#  name            = "legacy-token-mapper"
#  protocol        = "openid-connect"
#  protocol_mapper = "oidc-usermodel-attribute-mapper"
#  config = {
#    "user.attribute"       = "mercateo.shop_session.token"
#    "claim.name"           = "https://unite\\.eu/mppToken"
#    "id.token.claim"       = "true"
#    "access.token.claim"   = "true"
#    "userinfo.token.claim" = "true"
#    "jsonType.label"       = "String"
#  }
#}
#
#resource "keycloak_generic_protocol_mapper" "arkiva_view_open_id_attribute_mapper" {
#  realm_id        = module.client_arkiva.realm_id
#  client_id       = module.client_arkiva.id
#  name            = "customer-view-mapper"
#  protocol        = "openid-connect"
#  protocol_mapper = "oidc-usermodel-attribute-mapper"
#  config = {
#    "user.attribute"       = "mercateo.view_name"
#    "claim.name"           = "https://unite\\.eu/view"
#    "id.token.claim"       = "true"
#    "access.token.claim"   = "true"
#    "userinfo.token.claim" = "true"
#    "jsonType.label"       = "String"
#  }
#}
#
#resource "keycloak_generic_protocol_mapper" "upp_basket_id_open_id_attribute_mapper" {
#  realm_id        = module.client_arkiva.realm_id
#  client_id       = module.client_arkiva.id
#  name            = "upp-basket-id-mapper"
#  protocol        = "openid-connect"
#  protocol_mapper = "oidc-usermodel-attribute-mapper"
#  config = {
#    "user.attribute"       = "mercateo.basket_id"
#    "claim.name"           = "https://unite\\.eu/basketId"
#    "id.token.claim"       = "true"
#    "access.token.claim"   = "true"
#    "userinfo.token.claim" = "true"
#    "jsonType.label"       = "String"
#  }
#}