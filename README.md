# aws-ecs-code-pipeline

Herewith `terraform` for the ECS deployment and CI/CD steps. This Codepipeline support to trigger pipeline once you `push the code into CodeCommit`. In this repository, I will cover how I have approached it.

![text](/nginx-docker/aws-ecs.png)
#

## Environment Setup

Atached diagram included VPC stack. So I used `10.15.0.0/16` CIDR block to create two private and two public subnet. Public subnet deploy in this `10.15.0.0/18, 10.15.64.0/18` range and the privare subnet included in `10.15.128.0/18, 10.15.192.0/18`. The CodePipleine also included inside the VPC.

There are in multiple ways to trigger CodePipeline, the most common are:

+ Pipeline trigger, 
+ where it change in CodeCommit branch,
+ Manual Click 


Pre-requisite
+ ECR with images
+ ECS Cluster
+ CodeCommit

## Source
    We need to mentioned the `CodeCommit` code to define the CodePipeline to deploy at the end. CodeBuild will build the code and create image tag via the `#256`

## Build
    CodeBuild will generate the buildspec.yaml dynamically. The buildspec.yaml define the version of image it used in deployment.
