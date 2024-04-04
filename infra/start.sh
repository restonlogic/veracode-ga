#!/bin/bash -x

set -e

action=${$1:=apply}

ACCOUNTID=$(aws sts get-caller-identity | jq -r '.Account')
NAME=$(jq '.global_config.name' -r ./manifest.json)
ENVIRONMENT=$(jq '.global_config.environment' -r ./manifest.json)
REGION=$(jq '.global_config.region' -r ./manifest.json)
ORG=$(jq '.global_config.organization' -r ./manifest.json)

aws configure set default.region $REGION

BUCKET_NAME="tf-state-${NAME}-${ENVIRONMENT}-${ORG}-${ACCOUNTID}-github-actions"

# Disable exitting on error temporarily for ubuntu users. Below command checks to see if bucket exists.
set +e
rc=$(aws s3 ls s3://${BUCKET_NAME} >/dev/null 2>&1)
set -e
if [ -z $rc ]; then
    # Create bucket if not exist
    aws s3 mb s3://$BUCKET_NAME --region $REGION
else
    printf "Terraform state bucket exists.skipping\n"
fi

rm -rf .terraform
rm -rf .terraform.lock.hcl
terraform init \
    -backend-config="bucket=${BUCKET_NAME}" \
    -backend-config="region=$REGION" \
    -backend-config="key=${NAME}-${ENVIRONMENT}-secrets.tfstate"

terraform validate

case $action in
apply)
    echo "Running Terraform Apply Full"
    terraform apply -auto-approve -compact-warnings 
    ;;
destroy)
    echo "Running Terraform Destroy"
    terraform destroy -auto-approve -compact-warnings 
    ;;
plan)
    echo "Running Terraform Plan"
    terraform plan -compact-warnings \
    ;;
esac
