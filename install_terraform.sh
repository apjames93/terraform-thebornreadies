#!/bin/sh

set -eux

if [ ! -e terraform/terraform ]; then
  wget https://releases.hashicorp.com/terraform/0.12.23/terraform_0.12.23_linux_amd64.zip
  unzip terraform_0.12.23_linux_amd64.zip -d ~/bin
fi
