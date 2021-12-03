# Retrieves information about the HCP Packer "iteration"; an "iteration" can be
# thought of as all the metadata created by a single call of `packer build`.
data "hcp_packer_iteration" "app-image-iteration" {
  bucket_name = var.hcp_packer_bucket_name
  channel = var.environment
}

# Retrieves information about the HCP Packer "image"; an image can be thought
# of as all the metadata (including the artifact names) created by a single
# "source" builder; this can include multiple images so we provide a cloud
# region to disambiguate.
data "hcp_packer_image" "app-image" {
  bucket_name = var.hcp_packer_bucket_name
  iteration_id = data.hcp_packer_iteration.app-image-iteration.id
  cloud_provider = "docker"
  region = "docker"
}
