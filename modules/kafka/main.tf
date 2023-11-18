#terraform {
#  required_providers {
#    aiven = {
#      source  = "aiven/aiven"
#      version = "< 5.0.0"
#    }
#  }
#}

#resource "aiven_pg" "postgresql" {
#  project                = "arkiva"
#  service_name           = "postgresql"
#  cloud_name             = "google-europe-west3"
#  plan                   = "startup-4"
#
#  termination_protection = true
#}
#
#output "postgresql_service_uri" {
#  value     = aiven_pg.postgresql.service_uri
#  sensitive = true
#}

#VqXF78jkswc6YTgWztTaGipLddkYo+ozDZSOSjnJJKY9dWf9viKHWnRTgP4WrOR82Xv2hWFCb+k2SJkuCk05snbgeRAV2UZxB30On8V+foFFCN+UTPa1lSLgdtg89vutz1Jx/ldAPAqBU2r1CJqg7+wyC6DZd/pz/CACmPiN/i7SDzeUNVlwe7mnB+/Ou2kmFBsJG1tvr0OrCImrSDjADMRMtP0NuHm8rqbXOFwnALkojjbF8StiM9qO+SukTSIl7kV6dcsNnlF6idi8g19dN/CprySgqzrg/MHerbLXzKoBcmQgnNiE50lBwNXPVp2GRPAJN74YvNFtVSAeqUpiHvvKpoLpAPfzWjYmoD3Y5nHFa2E=