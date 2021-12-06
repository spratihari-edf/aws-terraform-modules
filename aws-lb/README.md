# aws-lb (Application and Network Load Balancer)

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_logs | Map containing access logging configuration for load balancer. | `map(string)` | `{}` | no |
| create\_lb | Controls if the Load Balancer should be created | `bool` | `true` | no |
| drop\_invalid\_header\_fields | Indicates whether invalid header fields are dropped in application load balancers. Defaults to false. | `bool` | `false` | no |
| enable\_cross\_zone\_load\_balancing | Indicates whether cross zone load balancing should be enabled in application load balancers. | `bool` | `false` | no |
| enable\_http2 | Indicates whether HTTP/2 is enabled in application load balancers. | `bool` | `true` | no |
| environment | The name of the environment | `any` | n/a | yes |
| extra\_ssl\_certs | A list of maps describing any extra SSL certificates to apply to the HTTPS listeners. Required key/values: certificate\_arn, https\_listener\_index (the index of the listener within https\_listeners which the cert applies toward). | `list(map(string))` | `[]` | no |
| http\_tcp\_listeners | A list of maps describing the HTTP listeners or TCP ports for this ALB. Required key/values: port, protocol. Optional key/values: target\_group\_index (defaults to http\_tcp\_listeners[count.index]) | `any` | `[]` | no |
| https\_listener\_rules | A list of maps describing the Listener Rules for this ALB. Required key/values: actions, conditions. Optional key/values: priority, https\_listener\_index (default to https\_listeners[count.index]) | `any` | `[]` | no |
| https\_listeners | A list of maps describing the HTTPS listeners for this ALB. Required key/values: port, certificate\_arn. Optional key/values: ssl\_policy (defaults to ELBSecurityPolicy-2016-08), target\_group\_index (defaults to https\_listeners[count.index]) | `any` | `[]` | no |
| idle\_timeout | The time in seconds that the connection is allowed to be idle. | `number` | `60` | no |
| internal | Boolean determining if the load balancer is internal or externally facing. | `bool` | `false` | no |
| ip\_address\_type | The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack. | `string` | `"ipv4"` | no |
| listener\_ssl\_policy\_default | The security policy if using HTTPS externally on the load balancer. [See](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-security-policy-table.html). | `string` | `"ELBSecurityPolicy-2016-08"` | no |
| load\_balancer\_create\_timeout | Timeout value when creating the ALB. | `string` | `"10m"` | no |
| load\_balancer\_delete\_timeout | Timeout value when deleting the ALB. | `string` | `"10m"` | no |
| load\_balancer\_type | The type of load balancer to create. Possible values are application or network. | `string` | `"application"` | no |
| load\_balancer\_update\_timeout | Timeout value when updating the ALB. | `string` | `"10m"` | no |
| name\_prefix | The resource name prefix and Name tag of the load balancer. Cannot be longer than 6 characters | `string` | `null` | no |
| override\_lb\_name | If user want to pass a name otherwise the name will be created by module | `any` | `null` | no |
| override\_tg\_name | If user want to pass a name otherwise the name will be created by module | `any` | `null` | no |
| project | The name of the project | `any` | n/a | yes |
| security\_groups | The security groups to attach to the load balancer. e.g. ["sg-edcd9784","sg-edcd9785"] | `list(string)` | `[]` | no |
| service | The name of the service | `any` | n/a | yes |
| subnet\_mapping | A list of subnet mapping blocks describing subnets to attach to network load balancer | `list(map(string))` | `[]` | no |
| subnets | A list of subnets to associate with the load balancer. e.g. ['subnet-1a2b3c4d','subnet-1a2b3c4e','subnet-1a2b3c4f'] | `list(string)` | `null` | no |
| target\_groups | A list of maps containing key/value pairs that define the target groups to be created. Order of these maps is important and the index of these are to be referenced in listener definitions. Required key/values: name, backend\_protocol, backend\_port | `any` | `[]` | no |
| vpc\_id | VPC id where the load balancer and other resources will be deployed. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| http\_tcp\_listener\_arns | The ARN of the TCP and HTTP load balancer listeners created. |
| http\_tcp\_listener\_ids | The IDs of the TCP and HTTP load balancer listeners created. |
| https\_listener\_arns | The ARNs of the HTTPS load balancer listeners created. |
| https\_listener\_ids | The IDs of the load balancer listeners created. |
| loadbalancer\_arn | The ID and ARN of the load balancer we created. |
| loadbalancer\_arn\_suffix | ARN suffix of our load balancer - can be used with CloudWatch. |
| loadbalancer\_dns\_name | The DNS name of the load balancer. |
| loadbalancer\_id | The ID and ARN of the load balancer we created. |
| loadbalancer\_zone\_id | The zone\_id of the load balancer to assist with creating DNS records. |
| target\_group\_arn\_suffixes | ARN suffixes of our target groups - can be used with CloudWatch. |
| target\_group\_arns | ARNs of the target groups. Useful for passing to your Auto Scaling group. |
| target\_group\_names | Name of the target group. Useful for passing to your CodeDeploy Deployment Group. |

