# Content Management System - Configuration files for CI/CD Pipeline (Used in AWS Developler Tools)

## appsec.yml

+ Application specification will be defined in appsec.yml and will use same to manage the deployment in the ci/cd pipeline.
+ appsec.yml will be used by CodeDeploy to determine following,
  + ECS task definition file
  + Application loadbalancer information (container name & port)

## buildspec.yml

+ buildspec.yml will contain build commands and related settings which is going to be used by CodeBuild to run the build
  + Env variables
    + Database connection url (refers SSM parameter store)
  + Build commands
    + Fetch all the dependancies
    + Compiles dependencies
    + Install all the packages described in package.json in the assets directory
    + Resets database (in RDS Postgres SQL)
    + Runs tests for the project

## prod-buildspec.yml

+ prod-buildspec.yml will use to build docker image in Production CI/CD pipeline

## Dockerfile

+ Describe commands to buld the custom docker image on top of the elxir latest docker image
  + Retrieve lastest version of elixir image from dockerhub public repository
  + Update & install package manager
  + Install & copy dependancies (hex, rebar)
  + Command instructions to run start_server.sh when starting to run docker image
+ Reference : <https://hub.docker.com/_/elixir>

## start_server.sh (following the instructions from ramansah/cms repo)

+ Migrating database
+ Start pheonix server

## taskdef.json

+ A task definition is required run docker containers in Amazson ECS
  + IAM role ARN that task should use
  + Container definition paramerts
    + Image name & reference
    + Ports mappings
    + Database information stored in SSM parameter store
  + Launch type (here we have used Fargate)
  + CPU
  + Memory
  + Network mode
  + Define task family name
