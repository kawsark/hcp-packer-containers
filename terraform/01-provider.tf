terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.20.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "hcp" {}
