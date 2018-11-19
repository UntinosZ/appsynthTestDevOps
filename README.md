# Appsynth DevOps Test

Hi! I'm Nopparid Mokpradab. I got some test from Appsynth for work in DevOps position.

## Installation
- [terraform](https://www.terraform.io/intro/getting-started/install.html)
- [awscli](https://docs.aws.amazon.com/cli/latest/userguide/installing.html)

## Elastic Beanstalk Variables Setup
Please open file **aws-eb/vars.tf** for change variables
| Name | Default | Description |
|-- |--| --|
|vpc_cidr | 10.0.33.0 | VPC CIDR (Should not same as other in your account) |
|key_name | | SSH Key name to use for access to ec2 instance |
|s3_bucket_name | | Default s3 bucket|
|app_domain | dev.tftest.local | Domain name |
|zone_domain | tftest.local | Zone Domain name |

## Elastic Beanstalk terraform run
1. Please run `aws configure` for config your AWS Credentials.
2. `cd aws-eb`
3. `terraform init`
4. `terraform apply`

When you finish check and need to remove all of terraform resource please use command `terraform destroy`