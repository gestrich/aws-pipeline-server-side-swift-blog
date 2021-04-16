Follow READ_ME except
  Instead of NPM command, run using CF_BUCKET=org.gestrich.codebuild ./scripts/create-stack.sh
    Can do this rather than use the NGM Command specified
  Wait for completion with 'aws cloudformation wait stack-create-complete'
pipeline.yml
  Get rid of:
    BuildBinaryAction
    EC2ReleaseAction
    EC2Application
    EC2DeploymentGroup
