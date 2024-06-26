# !/bin/bash

#Environment variables
export PROJECT_ID="active-dahlia-424818-m5"
export REGION="us-east1"
export DOMAIN="demobank.silver-en-irlanda.com"
export PRINCIPAL="silvergcpcert@gmail.com"

# Terraform state folder
echo "--- Running Terraform state folder"
gsutil mb gs://${PROJECT_ID}-boa-tf-state
gsutil versioning set on gs://${PROJECT_ID}-boa-tf-state

# Add Cloud Admin role to the current account silvergcpcert@gmail.com
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member="user:${PRINCIPAL}" --role=roles/storage.admin

# Terraform infrastructure
echo "--- Running Terraform Infrastructure"
terraform -chdir=iac/tf-multienv-cicd-anthos-autopilot init
terraform -chdir=iac/tf-multienv-cicd-anthos-autopilot apply

gcloud container fleet mesh describe




