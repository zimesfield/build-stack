variable "realm_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_name" {
  type = string
}

variable "access_token_lifespan_in_seconds" {
  type    = number
  default = null
}

variable "client_secret" {
  type    = string
  default = null
}

variable "access_type" {
  type = string
}

variable "web_origins" {
  type = set(string)
}

variable "redirect_uris" {
  type = set(string)
}

variable "browser_flow_id" {
  type    = string
  default = null
}

variable "default_scopes" {
  type = set(string)
}

variable "pkce_code_challenge_method" {
  description = "Either 'plain', 'S256' or empty ('')"
  type        = string
}

variable "login_theme" {
  description = "Set value to override default realm login theme 'unite' for client"
  type        = string
  default     = "unite"
}

# Value + used for Valid Post Logout Redirect URIs means that the logout will use 
# the same set of redirect URIs as specified by the option of Valid Redirect URIs.
# See https://www.keycloak.org/2022/07/keycloak-1900-released OIDC Logout changes section.
variable "post_logout_redirect_uri" {
  type    = set(string)
  default = ["+"]
}

# When true, the OAuth2 Client Credentials grant will be enabled for this client, which results in following settings
# Sets Standard Flow Enabled to OFF
# Sets Direct Access Grants Enabled to OFF (this is off by default for all clients at the moment)
# Sets Service Accounts Enabled to ON
variable "is_client_credentials_grant" {
  type    = bool
  default = false
}

variable "store_client_secret_in_ssm" {
  type    = bool
  default = false
}