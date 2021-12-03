## HCP Packer for Containers

This demo provides an example of using Packer to create a Docker container, and upload associate metadata to the HCP Packer registry. 

In the `terraform` directory, there is some sample code to lookup the image ID using the `hcp_packer_image` Data source. 

**TODO:**
- Deploy using terraform to a K8S cluster

**Pre-requisties:**
- HCP account
- Packer installed locally
- Docker installed locally
  - Please login to Dockerhub using the `docker login` command

### Usage - Packer
1. From your HCP Account:
- Create a new Bucket in HCP Packer called "learn-packer-alpine"
- Create a new Channel called "Dev"

2. Run the Docker build:
```bash
export HCP_CLIENT_ID=<hcp_client_id>
export HCP_CLIENT_SECRET=<hcp_client_secret>
packer build docker-alpine-vault.pkr.hcl
```

### Usage - Terraform
```bash
cd terraform
terraform init
...
terraform plan
...
terraform apply --auto-approve
...
terraform output
image_metadata = <<EOT
    cloud_image_id = sha256:c5796d44fa185004e873f89f06ca9f240770c6c8a46b639b2395c462715dab3a
    component_type = docker.alpine
    created_at = 2021-12-03T16:20:14.015Z
EOT
```
