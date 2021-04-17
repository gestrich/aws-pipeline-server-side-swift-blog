Follow READ_ME except
  Remember to set the instance count to 0 on initial creation of stack
  Instead of NPM command, run using CF_BUCKET=org.gestrich.codebuild ./scripts/create-stack.sh
    Can do this rather than use the NGM Command specified
  Wait for completion with 'aws cloudformation wait stack-create-complete'
pipeline.yml
  Get rid of:
    pipeline.vpc
      BuildBinaryAction
      EC2ReleaseAction
      EC2Application
      EC2DeploymentGroup
    vpc.yml
      	EC2LoadBalancer
      	EC2LBListener
      	Ec2LbUrl

On step "Pushing the Swift application code"
  IAM -> Users -> Bill -> Security Credentials
  Already had "HTTPS Git credentials for AWS CodeCommit"
  Actions -> Reset Password to get new git pw.


Parts to automate:
  Setting up ECR credentials locally
  Setting up CodeCommit push credentials
  Setting EC2 instance count to 0 and 2 automatically

