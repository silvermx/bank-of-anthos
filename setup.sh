# !/bin/bash

#Environment variables
export PROJECT_ID="active-dahlia-424818-m5"
export REGION="us-east1"
export DOMAIN="demobank.silver-en-irlanda.com"

# Terraform state folder
gsutil mb gs://${PROJECT_ID}-boa-tf-state
gsutil versioning set on gs://${PROJECT_ID}-boa-tf-state

# Terraform infrastructure
terraform -chdir=iac/tf-multienv-cicd-anthos-autopilot init
terraform -chdir=iac/tf-multienv-cicd-anthos-autopilot apply

gcloud container fleet mesh describe

