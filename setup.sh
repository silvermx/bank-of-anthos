# !/bin/bash

echo "### Prerequisites - Environment variables"
export TF_LOG=DEBUG
export PROJECT_ID="active-dahlia-424818-m5"
export REGION="us-east1"
export DOMAIN="demobank.silver-en-irlanda.com"
export PRINCIPAL="silvergcpcert@gmail.com"

# Not sure if this si required
echo "### Enableing Fleet mesh"
gcloud container fleet mesh enable --project active-dahlia-424818-m5

# Terraform state folder
echo "### Provisioning the infrastructure - Cloud Storage bucket"
gsutil mb gs://${PROJECT_ID}-boa-tf-state
gsutil versioning set on gs://${PROJECT_ID}-boa-tf-state

# Add Cloud Admin role to the current account silvergcpcert@gmail.com
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member="user:${PRINCIPAL}" --role=roles/storage.admin

# Terraform infrastructure
echo "--- Running Terraform Infrastructure"
terraform -chdir=iac/tf-multienv-cicd-anthos-autopilot init
terraform -chdir=iac/tf-multienv-cicd-anthos-autopilot apply

gcloud container fleet mesh describe

