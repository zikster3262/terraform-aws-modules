output "function_name" {
  value = var.lambda_inputs.name
}

output "lambda_exec_role" {
  value = aws_iam_role.this.arn
}
