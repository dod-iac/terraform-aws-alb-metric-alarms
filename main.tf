/**
 * ## Usage
 *
 * Creates two metric alarms for use with an ALB
 * * ALB 5XX Metric Alarm (Relating only to the ALB)
 * * ALB Target 5XX Metric Alarm (Relating only to the Target(s) behind the ALB)
 *
 * ```hcl
 * module "alb_metric_alarms" {
 *   source = "dod-iac/alb-mteric-alarms/aws"
 *
 *   name           = var.application
 *   environment    = var.environment
 *   alb_arn_suffix = module.alb_web_containers.alb_arn_suffix
 *
 *   actions_alarm             = [var.sns_topic_arn]
 *   actions_ok                = [var.sns_topic_arn]
 *   actions_insufficient_data = [var.sns_topic_arn]
 *
 *   alb_5xx_threshold        = "5"
 *   alb_target_5xx_threshold = "15"
 *
 *   tags = {
 *     Application = var.application
 *     Environment = var.environment
 *     Automation  = "Terraform"
 *   }
 * }
 * ```
 *
 * ## Terraform Version
 *
 * Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.
 *
 * Terraform 0.11 and 0.12 are not supported.
 *
 * ## License
 *
 * This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.
 */

resource "aws_cloudwatch_metric_alarm" "alb_5xx" {
  count = (var.alb_5xx_threshold > 0 && var.enable_alb_metric_alarm) ? 1 : 0

  alarm_name        = format("%s-%s-alb-5xx-limit", var.name, var.environment)
  alarm_description = format("At least %s%% of traffic to the ALB in %s %s is returning 5xx error codes. Does not apply to 5xx errors coming from the backends.", var.alb_5xx_threshold, var.name, var.environment)

  actions_enabled           = var.actions_enabled
  alarm_actions             = var.actions_alarm
  ok_actions                = var.actions_ok
  insufficient_data_actions = var.actions_insufficient_data

  metric_query {
    id          = "e1"
    expression  = "m2/m1*100"
    label       = "Error Rate"
    return_data = "true"
  }

  metric_query {
    id = "m1"

    metric {
      metric_name = "RequestCount"
      namespace   = "AWS/ApplicationELB"
      period      = "300"
      stat        = "Sum"
      unit        = "Count"

      dimensions = {
        LoadBalancer = var.alb_arn_suffix
      }
    }
  }

  metric_query {
    id = "m2"

    metric {
      metric_name = "HTTPCode_ELB_5XX_Count"
      namespace   = "AWS/ApplicationELB"
      period      = "300"
      stat        = "Sum"
      unit        = "Count"

      dimensions = {
        LoadBalancer = var.alb_arn_suffix
      }
    }
  }

  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = var.alb_5xx_threshold
  evaluation_periods  = "1"
  treat_missing_data  = "notBreaching"

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "alb_target_5xx" {
  count = (var.alb_target_5xx_threshold > 0 && var.enable_alb_target_metric_alarm) ? 1 : 0

  alarm_name        = format("%s-%s-alb-target-5xx-limit", var.name, var.environment)
  alarm_description = format("At least %s%% of traffic to the Target(s) behind the ALB in %s %s is returning 5xx error codes. Does not apply to 5xx errors coming from the backends.", var.alb_target_5xx_threshold, var.name, var.environment)

  actions_enabled           = var.actions_enabled
  alarm_actions             = var.actions_alarm
  ok_actions                = var.actions_ok
  insufficient_data_actions = var.actions_insufficient_data

  metric_query {
    id          = "e1"
    expression  = "m2/m1*100"
    label       = "Error Rate"
    return_data = "true"
  }

  metric_query {
    id = "m1"

    metric {
      metric_name = "RequestCount"
      namespace   = "AWS/ApplicationELB"
      period      = "300"
      stat        = "Sum"
      unit        = "Count"

      dimensions = {
        LoadBalancer = var.alb_arn_suffix
      }
    }
  }

  metric_query {
    id = "m2"

    metric {
      metric_name = "HTTPCode_Target_5XX_Count"
      namespace   = "AWS/ApplicationELB"
      period      = "300"
      stat        = "Sum"
      unit        = "Count"

      dimensions = {
        LoadBalancer = var.alb_arn_suffix
      }
    }
  }

  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = var.alb_target_5xx_threshold
  evaluation_periods  = "1"
  treat_missing_data  = "notBreaching"

  tags = var.tags
}
