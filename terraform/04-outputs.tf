output "image_metadata" {
  value = <<EOF
    cloud_image_id = ${data.hcp_packer_image.app-image.cloud_image_id}
    component_type = ${data.hcp_packer_image.app-image.component_type}
    created_at = ${data.hcp_packer_image.app-image.created_at}
  EOF
}


