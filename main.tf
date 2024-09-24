module "keycloak-database" {
  source = "git::https://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@git@github.com:zimesfield/infrastructure-stack.git//modules/postgres?ref=v0.0.2"
  namespace_name          = "keycloak"
  chart_name              = "postgresql"
  app_name                = "keycloak-database"
  app_version             = "13.1.2"
  db_name                 = "keycloak_db"
  db_username             = "keycloak"
  db_password             = "keycloak2"
}

module "keycloak-server" {
  source = "git::https://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@git@github.com:zimesfield/infrastructure-stack.git//modules/keycloak?ref=v0.0.2"
  depends_on = [module.keycloak-database]
  namespace_name          = "keycloak"
  chart_name              = "keycloak"
  app_version             = "16.1.5"
  app_name                = "keycloak-server"
  username                = "admin"
  password                = "admin2"
  db_host                 = module.keycloak-database.database_host
  db_port                 = "5432"
  db_name                 = "keycloak_db"
  db_username             = "keycloak"
  db_password_secret      = "keycloak-database-postgresql"
  db_password_key         = "password"
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
