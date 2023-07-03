data "archive_file" "zip" {
  type             = var.archive_file_inputs.archive_type
  source_dir       = var.archive_file_inputs.source_dir
  output_path      = var.archive_file_inputs.output_path
  excludes         = var.archive_file_inputs.excludes
  output_file_mode = var.archive_file_inputs.output_file_mode
}

resource "aws_lambda_function" "this" {
  function_name    = var.lambda_inputs.name
  filename         = data.archive_file.zip.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256
  role             = aws_iam_role.this.arn
  handler          = var.lambda_inputs.handler
  runtime          = local.lambda_inputs.runtime
  timeout          = local.lambda_inputs.timeout


  dynamic "vpc_config" {
    for_each = var.vpc_subnet_ids != null && var.vpc_security_group_ids != null ? [true] : []
    content {
      security_group_ids = var.vpc_security_group_ids
      subnet_ids         = var.vpc_subnet_ids
    }
  }

  dynamic "environment" {
    for_each = length(keys(var.environment_variables)) == 0 ? [] : [true]
    content {
      variables = var.environment_variables
    }
  }

  depends_on = [data.archive_file.zip, aws_iam_role.this]
}

resource "aws_cloudwatch_log_group" "this" {
  count             = var.enable_logs ? 1 : 0
  name              = "/aws/lambda/${var.lambda_inputs.name}"
  retention_in_days = var.logs_retention_days
  depends_on        = [aws_lambda_function.this]
}

