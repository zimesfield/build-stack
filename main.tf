module "keycloak-database" {
  source         = "git::git@github.com:zimesfield/infrastructure-stack.git//modules/postgres?ref=v0.1.7"
  namespace_name = "keycloak"
  chart_name     = "postgresql"
  app_name       = "keycloak-database"
  app_version    = "13.1.2"
  db_name        = var.keycloak_database
  db_username    = var.keycloak_database_username
  db_password    = var.keycloak_database_password
}

module "keycloak-server" {
  source             = "git::git@github.com:zimesfield/infrastructure-stack.git//modules/keycloak?ref=v0.1.7"
  depends_on         = [module.keycloak-database]
  namespace          = "keycloak"
  chart              = "keycloak"
  app_version        = "16.1.5"
  app_name           = "keycloak-server"
  username           = var.keycloak_admin_username
  password           = var.keycloak_admin_password
  db_host            = "keycloak-database-postgresql"
  db_port            = var.keycloak_port
  db_name            = var.keycloak_database
  db_username        = var.keycloak_database_username
  db_password_secret = "keycloak-database-postgresql"
  db_password_key    = "password"
}



#provider "keycloak" {
#  client_id = "master-realm"
#  url       = "https://${module.keycloak-server.keycloak_host}"
#  client_secret = "admin2"
#}
#
#module "build_stack" {
#  source                    = "./modules"
#  account_name              = "local"
#}
