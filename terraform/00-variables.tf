# This variable is also used as the HCP packer channel name
variable "environment" {
  description = "The environment is used as labels and channel name"
  default = "Dev"
}

variable "kube_config_path" {
  description = "Provide the path to kube config file"
  default = "~/.kube/config"
}

variable "hcp_packer_bucket_name" {
  description = "Provide the bucket name from hcp packer"
  default = "learn-packer-alpine"
}

