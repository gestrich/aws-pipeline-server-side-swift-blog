#!/bin/bash


STACK_NAME="swift-build"

function createStack {
  CF_BUCKET=org.gestrich.codebuild ./scripts/create-stack.sh
  aws cloudformation wait stack-create-complete --stack-name $STACK_NAME 
  #aws cloudformation create-stack --cli-input-json file://create-stack.json --template-body file://./simple.yml
}

function updateStack {
  CF_BUCKET=org.gestrich.codebuild ./scripts/update-stack.sh
  aws cloudformation wait stack-update-complete --stack-name $STACK_NAME 
  #aws cloudformation update-stack --cli-input-json file://create-stack.json --template-body file://./simple.yml
  #aws cloudformation wait stack-update-complete --stack-name $STACK_NAME  
}

function deleteStack {
  aws s3 rm s3://$(aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[0].Outputs[?OutputKey=='S3ArtifactBucket'].OutputValue" --output text)/ --recursive
  IMAGES_TO_DELETE=$(aws ecr list-images --repository-name codebuild/swift --query 'imageIds[*]' --output json)
  aws ecr batch-delete-image --repository-name codebuild/swift --image-ids "$IMAGES_TO_DELETE"
  IMAGES_TO_DELETE=$(aws ecr list-images --repository-name swift-app --query 'imageIds[*]' --output json)
  aws ecr batch-delete-image --repository-name swift-app --image-ids "$IMAGES_TO_DELETE"

  aws cloudformation delete-stack --stack-name $STACK_NAME
  aws cloudformation wait stack-delete-complete --stack-name $STACK_NAME
}

# Check if the function exists (bash specific)
if [ $# -gt 0 ]; then
#if declare -f "$1" > /dev/null
  # call arguments verbatim
  "$@"
else
  # Show a helpful error
  echo "Run again, followed by function name:\n"
  typeset -f | awk '!/^main[ (]/ && /^[^ {}]+ *\(\)/ { gsub(/[()]/, "", $1); print $1}'
  exit 1
fi
