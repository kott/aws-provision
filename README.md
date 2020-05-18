# aws-provision

This repo will be a collection of scripts to provision new environments in AWS. In particular, this will focus on deploying to ECS clusters.

So far this repository can provision the following resources on AWS:
* VPC
* Subnets (3 public, 3 private, across 3 availability zones)
* Routing tables
* Security groups 

## Installation

Prior to using anything defined in this repository, you will need the following:
* terraform CLI (instructions can be found [here](https://learn.hashicorp.com/terraform/getting-started/install))
* AWS account

## Usage
Make you AWS credentials available to terraform:
```bash
export AWS_ACCESS_KEY_ID=<key_ID>
export AWS_SECRET_ACCESS_KEY=<super_top_secret_key>
```

The idea behind the structure of this repository was to allow one to provision a new environment by just adding a new 
variables file (an attempt at a 12-factor-like solution). E.g. say we want an environment called "feature". Then we 
create the feature.tfvars file with the appropriate attributes (AWS region, CIDR blocks, etc.), and run the terraform templates
with these new variables: 

* `terraform init`
* `terraform plan -var-file=./feature.tfvars`
* `terraform apply -var-file=./feature.tfvars`

If all goes well the resources should now be visible in the AWS console.
