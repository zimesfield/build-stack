terraform {
  required_version = ">= 1.0"
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "2.29.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.15.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.35.1"
    }
  }
}

provider "linode" {
  token = var.token
}

locals {
  config_path    = var.kube_config_path
  config_context = var.config
}

provider "kubernetes" {
  config_path    = local.config_path
  config_context = local.config_context
}

provider "helm" {
  kubernetes {
    config_path    = local.config_path
    config_context = local.config_context
  }
}

