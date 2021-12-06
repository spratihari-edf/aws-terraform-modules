## Description
This module will create an auto scaling group with launch configuration


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| asg\_name | Creates a unique name for autoscaling group beginning with the specified prefix | `string` | `""` | no |
| default\_cooldown | The amount of time, in seconds, after a scaling activity completes before another scaling activity can start | `number` | `300` | no |
| desired\_capacity | The number of Amazon EC2 instances that should be running in the group | `string` | n/a | yes |
| ebs\_block\_device | Additional EBS block devices to attach to the instance | `list(map(string))` | `[]` | no |
| ebs\_optimized | If true, the launched EC2 instance will be EBS-optimized | `bool` | `false` | no |
| ec2\_ami\_id | The EC2 image ID to launch | `string` | `""` | no |
| enable\_monitoring | Enables/disables detailed monitoring. This is enabled by default. | `bool` | `true` | no |
| enabled\_metrics | A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances | `list(string)` | <pre>[<br>  "GroupMinSize",<br>  "GroupMaxSize",<br>  "GroupDesiredCapacity",<br>  "GroupInServiceInstances",<br>  "GroupPendingInstances",<br>  "GroupStandbyInstances",<br>  "GroupTerminatingInstances",<br>  "GroupTotalInstances"<br>]</pre> | no |
| ephemeral\_block\_device | Customize Ephemeral (also known as 'Instance Store') volumes on the instance | `list(map(string))` | `[]` | no |
| health\_check\_grace\_period | Time (in seconds) after instance comes into service before checking health | `number` | `300` | no |
| health\_check\_type | Controls how health checking is done. Values are - EC2 and ELB | `string` | n/a | yes |
| iam\_instance\_profile | The IAM instance profile to associate with launched instances | `string` | `""` | no |
| initial\_lifecycle\_hook\_details | Details of initial\_lifecycle\_hook | `list(map(string))` | `[]` | no |
| instance\_type | The size of instance to launch | `string` | `""` | no |
| key\_name | The key name that should be used for the instance | `string` | `""` | no |
| landscape | In which landscape EC2 will be provisioned. MA/LZ | `string` | `"LZ"` | no |
| launch\_config\_name | Creates a unique name for launch configuration beginning with the specified prefix | `string` | `""` | no |
| load\_balancers | A list of elastic load balancer names to add to the autoscaling group names | `list(string)` | `[]` | no |
| max\_size | The maximum size of the auto scale group | `string` | n/a | yes |
| min\_elb\_capacity | Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes | `number` | `0` | no |
| min\_size | The minimum size of the auto scale group | `string` | n/a | yes |
| placement\_group | The name of the placement group into which you'll launch your instances, if any | `string` | `""` | no |
| placement\_tenancy | The tenancy of the instance. Valid values are 'default' or 'dedicated' | `string` | `"default"` | no |
| protect\_from\_scale\_in | Allows setting instance protection. The autoscaling group will not select instances with this setting for termination during scale in events. | `bool` | `false` | no |
| root\_block\_device | Customize details about the root block device of the instance | `list(map(string))` | `[]` | no |
| security\_group\_id | A list of security group IDs to assign to the launch configuration | `list(string)` | `[]` | no |
| service\_linked\_role\_arn | The ARN of the service-linked role that the ASG will use to call other AWS services. | `string` | `""` | no |
| subnet\_ids | A list of subnet IDs to launch resources in | `list(string)` | `[]` | no |
| suspended\_processes | A list of processes to suspend for the AutoScaling Group. The allowed values are Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZRebalance, AlarmNotification, ScheduledActions, AddToLoadBalancer. Note that if you suspend either the Launch or Terminate process types, it can prevent your autoscaling group from functioning properly. | `list(string)` | `[]` | no |
| tags\_override | A custom map of tags to override default tags | `map(string)` | `{}` | no |
| target\_group\_arns | A list of aws\_alb\_target\_group ARNs, for use with Application Load Balancing | `list(string)` | `[]` | no |
| termination\_policies | A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default | `list(string)` | <pre>[<br>  "Default"<br>]</pre> | no |
| user\_data | The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user\_data\_base64 instead. | `string` | `null` | no |
| user\_data\_base64 | Can be used instead of user\_data to pass base64-encoded binary data directly. Use this instead of user\_data whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption. | `string` | `null` | no |
| vpc\_id | VPC ID of AWS account | `string` | n/a | yes |
| wait\_for\_elb\_capacity | Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over min\_elb\_capacity behavior. | `number` | `null` | no |

### life cycle hook

variable initial_lifecycle_hook_details, is a map of string and accepts below values

| Name | Default |
|------|-------------|
| initial\_lifecycle\_hook\_name | asg-lifecycle-hook |
| initial\_lifecycle\_hook\_default\_result | ABANDON |
| initial\_lifecycle\_hook\_heartbeat\_timeout | 60 |
| initial\_lifecycle\_hook\_lifecycle\_transition | n/a |
| initial\_lifecycle\_hook\_notification\_metadata | n/a |
| initial\_lifecycle\_hook\_notification\_target\_arn | n/a |
| initial\_lifecycle\_hook\_role\_arn | n/a |


## Outputs

| Name | Description |
|------|-------------|
| auto\_scaling\_group | object with all attributes for autoscaling group. |
| launch\_configuration | object with all attributes for launch configuration. |

