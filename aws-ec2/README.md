## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.3 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami\_id | Amazone machine image id | `string` | n/a | yes |
| ebs\_block\_device | List of EBS block devices | `list` | `[]` | no |
| ebs\_volume | List of EBS volumes to be attached | `list` | `[]` | no |
| ec2\_instance\_size | Ec2 instance t-shirt size | `string` | n/a | yes |
| ec2\_key\_name | ec2 key pair name | `string` | n/a | yes |
| ec2\_role\_name | Ec2 IAM Instance profile to create. Default is lz-glo-iam-rol-ssm\_protected for LZ and AWS\_DUB\_ROL\_SSM\_protected / AWS\_LON\_ROL\_SSM\_protected for MA | `any` | `null` | no |
| edfe\_environment | EDFE Environment Production/Preproduction | `string` | n/a | yes |
| environment | Environment secondary/primary | `string` | n/a | yes |
| kms\_key\_arn | Kms key using which EBS volume will be encrypted | `string` | n/a | yes |
| landscape | In which landscape EC2 will be provisioned. MA/LZ | `string` | `"LZ"` | no |
| name | EC2 name. | `any` | n/a | yes |
| patch\_group | Name of the patch group which will patch the ec2 instance | `string` | n/a | yes |
| patching\_enabled | Enable patching | `bool` | `"true"` | no |
| policy\_document | Ec2 IAM policy document to be attached to the Instance profile | `bool` | `false` | no |
| policy\_name | Ec2 IAM Instance profile policy name | `any` | `null` | no |
| private\_ip | static ip | `string` | `""` | no |
| project | Project name Ex. LZ | `string` | n/a | yes |
| root\_volume\_size | Optional: Root volume size in GB | `string` | `"50"` | no |
| root\_volume\_type | Optional: Root volume type | `string` | `"gp2"` | no |
| root\_volume\_iops | Root volume IOPs | `number` | `3000` | no |
| root\_volume\_throuput | Root volume throughput | `number` | `125` | no |
| security\_group\_id | Security group id | `list(string)` | n/a | yes |
| service | Service | `string` | n/a | yes |
| subnetid | subnet id in which instance will be created | `string` | n/a | yes |
| tags\_override | A custom map of tags to override default tags | `map(string)` | `{}` | no |
| user\_data | User data | `string` | `""` | no |
| disable\_api\_termination | Disable API Termination | `bool` | `false` | no |
| ebs\_optimized | Should the instance be EBS optimized | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| ec2\_instance | This is ec2 instance object |
| instance\_profile\_name | Instance profile name for future use |
