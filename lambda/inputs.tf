# source_dir       = "${path.module}/lambda/putItem"
# output_path      = "${path.module}/lambda/putItem/hw-${random_string.r.result}.zip"
# excludes         = ["${path.module}/lambda/putItem/node_modules"]
# output_file_mode = "0666"


variable "lambda_inputs" {
  type = object({
    name    = string
    handler = optional(string)
    runtime = optional(string)
    timeout = optional(number)
  })

  description = "Lambda function inputs"
}

variable "environment_variables" {
  description = "A map that defines environment variables for the Lambda Function."
  type        = map(string)
  default     = {}
}

variable "vpc_subnet_ids" {
  description = "List of subnet ids when Lambda Function should run in the VPC. Usually private or intra subnets."
  type        = list(string)
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of security group ids when Lambda Function should run in the VPC."
  type        = list(string)
  default     = null
}

variable "archive_file_inputs" {
  description = "Path to the lambda function and its directories"
  type = object({
    archive_type     = optional(string)
    source_dir       = optional(string)
    output_path      = optional(string)
    excludes         = optional(list(string))
    output_file_mode = optional(string)
  })

  default = {
    archive_type     = "zip"
    excludes         = []
    output_path      = null
    source_dir       = null
    output_file_mode = "0666"
  }
}

variable "enable_logs" {
  type        = bool
  default     = true
  description = "Enable or Disable cloudwatch logs"
}

variable "logs_retention_days" {
  type        = number
  default     = 5
  description = "Specifying number of days to preserve the logs"
}



locals {
  lambda_inputs = merge(var.lambda_inputs, {
    timeout = 3
    runtime = "nodejs16.x"
  })
}
