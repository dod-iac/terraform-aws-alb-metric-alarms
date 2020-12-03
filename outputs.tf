
output "alb_5xx_metric_alarm_id" {
  description = "The ID of the ALB 5XX metric alarm"
  value       = aws_cloudwatch_metric_alarm.alb_5xx[0].id
}

output "alb_5xx_metric_alarm_arn" {
  description = "The ARN of the ALB 5XX metric alarm"
  value       = aws_cloudwatch_metric_alarm.alb_5xx[0].arn
}

output "alb_target_5xx_metric_alarm_id" {
  description = "The ID of the ALB Target 5XX metric alarm"
  value       = aws_cloudwatch_metric_alarm.alb_target_5xx[0].id
}

output "alb_target_5xx_metric_alarm_arn" {
  description = "The ARN of the ALB Target 5XX metric alarm"
  value       = aws_cloudwatch_metric_alarm.alb_target_5xx[0].arn
}
