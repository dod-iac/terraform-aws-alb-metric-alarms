## Usage

Creates two metric alarms for use with an ALB
* ALB 5XX Metric Alarm (Relating only to the ALB)
* ALB Target 5XX Metric Alarm (Relating only to the Target(s) behind the ALB)

```hcl
module "alb_metric_alarms" {
  source = "dod-iac/alb-mteric-alarms/aws"

  name        = var.application
  environment = var.environment
  alb_arn_suffix = module.alb_web_containers.alb_arn_suffix

  actions_alarm             = [var.sns_topic_arn]
  actions_ok                = [var.sns_topic_arn]
  actions_insufficient_data = [var.sns_topic_arn]

  alb_5xx_threshold        = "5"
  alb_target_5xx_threshold = "15"

  tags = {
    Application = var.application
    Environment = var.environment
    Automation  = "Terraform"
  }
}
```

## Terraform Version

Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.

Terraform 0.11 and 0.12 are not supported.

## License

This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.13.0 |
| aws | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| actions\_alarm | List of alarm actions to take | `list(string)` | `[]` | no |
| actions\_enabled | Enable the actions. Set to false to temporarily disable actions. | `bool` | `true` | no |
| actions\_insufficient\_data | List of insufficient data actions to take | `list(string)` | `[]` | no |
| actions\_ok | List of ok actions to take | `list(string)` | `[]` | no |
| alb\_5xx\_threshold | The 5XX threshold for the ALB metric alarm | `string` | `"10"` | no |
| alb\_arn\_suffix | The ARN Suffix of the ALB for use with CloudWatch Metrics. | `string` | n/a | yes |
| alb\_target\_5xx\_threshold | The 5XX threshold for the ALB target metric alarm | `string` | `"10"` | no |
| enable\_alb\_metric\_alarm | Enable the ALB metric alarm | `bool` | `true` | no |
| enable\_alb\_target\_metric\_alarm | Enable the ALB target metric alarm | `bool` | `true` | no |
| environment | Environment tag, e.g prod. | `string` | n/a | yes |
| name | The service name. | `string` | n/a | yes |
| tags | Tags applied to the metric alarms. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| alb\_5xx\_metric\_alarm\_arn | The ARN of the ALB 5XX metric alarm |
| alb\_5xx\_metric\_alarm\_id | The ID of the ALB 5XX metric alarm |
| alb\_target\_5xx\_metric\_alarm\_arn | The ARN of the ALB Target 5XX metric alarm |
| alb\_target\_5xx\_metric\_alarm\_id | The ID of the ALB Target 5XX metric alarm |

