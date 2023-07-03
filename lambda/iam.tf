
# // PutItem Lambda IAM policies
resource "aws_iam_role" "this" {
  name = "${var.lambda_inputs.name}-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "AWSRoleAttachment" {
  count      = var.policy_arn != null ? 1 : 0
  role       = aws_iam_role.this.name
  policy_arn = var.policy_arn
}

resource "aws_iam_role_policy_attachment" "AWSLambdaBasicExecutionRoles" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "AWSLambdaVPCAccessExecutionRole" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

