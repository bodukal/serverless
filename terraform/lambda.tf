resource "aws_lambda_function" "s3_trigger" {
  function_name    = var.lambda_function_name
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "handler.lambda_handler"     
  runtime          = "python3.9"
  filename         = "${path.module}/../build/function.zip"
  source_code_hash = filebase64sha256("${path.module}/../build/function.zip")
}

