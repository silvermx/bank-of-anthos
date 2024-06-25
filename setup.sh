# !/bin/bash

export PROJECT_ID="active-dahlia-424818-m5"
export REGION="us-east1"
export DOMAIN="demobank.silver-en-irlanda.com"


gsutil mb gs://${PROJECT_ID}-boa-tf-state
gsutil versioning set on gs://${PROJECT_ID}-boa-tf-state

run from iac/tf-multienv-cicd-anthos-autopilot
   terraform init && \
   terraform apply

gcloud container fleet mesh describe

