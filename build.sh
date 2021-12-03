#!/bin/bash
#export HCP_PACKER_BUILD_FINGERPRINT=$(head /dev/random | md5)
packer build docker-alpine-vault.pkr.hcl
