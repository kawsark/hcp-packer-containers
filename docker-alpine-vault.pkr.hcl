packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source  = "github.com/hashicorp/docker"
    }
  }
}

# Variables
variable "terraform_version" {
  type =  string
  default = "1.1.0-beta2"
}

variable "vault_version" {
  type =  string
  default = "1.9.0"
}

# Construct the terraform and vault download URLs
locals {
  terraform_url = "https://releases.hashicorp.com/terraform/${var.terraform_version}/terraform_${var.terraform_version}_linux_amd64.zip"
  vault_url = "https://releases.hashicorp.com/vault/${var.vault_version}/vault_${var.vault_version}_linux_amd64.zip"
}

source "docker" "alpine" {
  image  = "alpine:3.14"
  commit = true
  changes = [
      "EXPOSE 8200",
      "LABEL version=${var.vault_version}",
      "ENTRYPOINT /bin/vault server -dev"
    ]
}

build {
  name = "learn-packer"

  hcp_packer_registry {
    bucket_name = "learn-packer-alpine"
    description = "Alpine Vault container image" 
    labels = {
      "alpine" = "3.14",
      "app"    = "vault",
    }
  }


  sources = [
    "source.docker.alpine"
  ]
  # Install packages
  provisioner "shell" {
    inline = ["apk update", "apk add wget unzip"]
  }

  # Install terraform
  provisioner "shell" {
    inline = ["wget -O terraform.zip ${local.terraform_url}", "unzip terraform.zip", "rm -f ./terraform.zip", "mv ./terraform /bin", "chmod +x /bin/terraform", "terraform --version"]
  }

  # Install vault
  provisioner "shell" {
    inline = ["wget -O vault.zip ${local.vault_url}", "unzip vault.zip", "rm -f ./terraform.zip", "mv ./vault /bin", "chmod +x /bin/vault", "vault --version"]
  }

  post-processors {
    post-processor "docker-tag" {
        repository =  "kawsark/alpine-vault"
        tags = ["0.1"]
      }
    post-processor "docker-push" {}
  }

}
