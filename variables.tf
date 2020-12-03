variable "name" {
  type        = string
  description = "The service name."
}

variable "environment" {
  type        = string
  description = "Environment tag, e.g prod."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the metric alarms."
  default     = {}
}

variable "enable_alb_metric_alarm" {
  type        = bool
  description = "Enable the ALB metric alarm"
  default     = true
}

variable "enable_alb_target_metric_alarm" {
  type        = bool
  description = "Enable the ALB target metric alarm"
  default     = true
}

variable "actions_enabled" {
  type        = bool
  description = "Enable the actions. Set to false to temporarily disable actions."
  default     = true
}

variable "actions_alarm" {
  type        = list(string)
  description = "List of alarm actions to take"
  default     = []
}

variable "actions_ok" {
  type        = list(string)
  description = "List of ok actions to take"
  default     = []
}

variable "actions_insufficient_data" {
  type        = list(string)
  description = "List of insufficient data actions to take"
  default     = []
}

variable "alb_arn_suffix" {
  type        = string
  description = "The ARN Suffix of the ALB for use with CloudWatch Metrics."
}

variable "alb_5xx_threshold" {
  type        = string
  description = "The 5XX threshold for the ALB metric alarm"
  default     = "10"
}

variable "alb_target_5xx_threshold" {
  type        = string
  description = "The 5XX threshold for the ALB target metric alarm"
  default     = "10"
}
