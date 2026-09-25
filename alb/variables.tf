variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "alb_name" {
  description = "Application Load Balancer name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "subnets" {
  description = "Subnet IDs for the ALB"
  type        = list(string)
}

variable "security_groups" {
  description = "Security group IDs for the ALB"
  type        = list(string)
}

variable "internal" {
  description = "Whether the ALB is internal"
  type        = bool
  default     = true
}

variable "ip_address_type" {
  description = "ALB IP address type"
  type        = string
  default     = "ipv4"
}

variable "enable_deletion_protection" {
  description = "Enable ALB deletion protection"
  type        = bool
  default     = false
}

variable "enable_http2" {
  description = "Enable HTTP/2"
  type        = bool
  default     = true
}

variable "target_groups" {
  description = "ALB target groups"

  type = list(object({
    name                       = string
    port                       = number
    protocol                   = optional(string, "HTTP")
    target_type                = optional(string, "instance")
    health_check_path          = optional(string, "/")
    health_check_protocol      = optional(string, "HTTP")
    health_check_interval      = optional(number, 30)
    health_check_timeout       = optional(number, 5)
    healthy_threshold          = optional(number, 5)
    unhealthy_threshold        = optional(number, 2)
    health_check_matcher       = optional(string, "200-299")
    deregistration_delay       = optional(number, 300)
    stickiness_enabled         = optional(bool, false)
    stickiness_type            = optional(string, "lb_cookie")
    stickiness_cookie_duration = optional(number, 86400)

    targets = optional(list(object({
      target_id = string
      port      = optional(number)
      az        = optional(string)
    })), [])
  }))

  default = []
}

variable "listeners" {
  description = "ALB listener configuration"

  type = list(object({
    port            = number
    protocol        = optional(string, "HTTP")
    ssl_policy      = optional(string, null)
    certificate_arn = optional(string, null)

    default_actions = list(object({
      type             = string
      target_group_arn = optional(string, null)

      redirect_config = optional(object({
        protocol    = optional(string, "HTTP")
        port        = optional(string, "80")
        host        = optional(string, "#{host}")
        path        = optional(string, "/#{path}")
        query       = optional(string, "#{query}")
        status_code = optional(string, "HTTP_301")
      }), null)

      fixed_response_config = optional(object({
        content_type = string
        message_body = optional(string, "")
        status_code  = optional(string, "200")
      }), null)
    }))
  }))

  default = []
}

variable "tags" {
  description = "Additional ALB tags"
  type        = map(string)
  default     = {}
}
