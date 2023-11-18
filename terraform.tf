terraform {
  required_version = ">= 1.0"
  required_providers {
#    helm = {
#      source = "hashicorp/helm"
#      version = "2.11.0"
#    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.23.0"
    }
    keycloak = {
      source  = "mrparkers/keycloak"
      version = "4.3.1"
    }
#    aiven = {
#      source  = "aiven/aiven"
#      version = "4.9.3"
#    }
  }
}

locals {
  config_path = "~/.kube/config"
  config_context = "minikube"
}

provider "kubernetes" {
  config_path = local.config_path
  config_context = local.config_context
}

provider "helm" {
  kubernetes {
    config_path             = local.config_path
    config_context          = local.config_context
  }
}

provider "keycloak" {
  client_id     = "terraform"
  client_secret = "884e0f95-0f42-4a63-9b1f-94274655669e"
  url           = "http://localhost:8080"
  additional_headers = {
    foo = "bar"
  }
}

#provider "aiven" {
#  api_token = "VqXF78jkswc6YTgWztTaGipLddkYo+ozDZSOSjnJJKY9dWf9viKHWnRTgP4WrOR82Xv2hWFCb+k2SJkuCk05snbgeRAV2UZxB30On8V+foFFCN+UTPa1lSLgdtg89vutz1Jx/ldAPAqBU2r1CJqg7+wyC6DZd/pz/CACmPiN/i7SDzeUNVlwe7mnB+/Ou2kmFBsJG1tvr0OrCImrSDjADMRMtP0NuHm8rqbXOFwnALkojjbF8StiM9qO+SukTSIl7kV6dcsNnlF6idi8g19dN/CprySgqzrg/MHerbLXzKoBcmQgnNiE50lBwNXPVp2GRPAJN74YvNFtVSAeqUpiHvvKpoLpAPfzWjYmoD3Y5nHFa2E="
#}

