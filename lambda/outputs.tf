output "function_name" {
  value = var.lambda_inputs.name
}

output "exec_role" {
  value = aws_iam_role.this.arn
}

output "exec_role_name" {
  value = aws_iam_role.this.name
}

output "invoke_arn" {
  value = aws_lambda_function.this.invoke_arn
}

output "arn" {
  value = aws_lambda_function.this.arn
}
