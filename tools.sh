#!/bin/bash


STACK_NAME="swift-build"

function createStack {
  CF_BUCKET=org.gestrich.codebuild ./scripts/create-stack.sh
  #aws cloudformation create-stack --cli-input-json file://create-stack.json --template-body file://./simple.yml
  aws cloudformation wait stack-create-complete --stack-name $STACK_NAME 
}

function updateStack {
  aws cloudformation update-stack --cli-input-json file://create-stack.json --template-body file://./simple.yml
  aws cloudformation wait stack-update-complete --stack-name $STACK_NAME  
}

function deleteStack {
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
