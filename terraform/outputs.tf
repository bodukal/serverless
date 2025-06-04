output "api_url" {
  description = "The invoke URL of the API Gateway HTTP API"
  value       = aws_apigatewayv2_stage.default_stage.invoke_url
}

output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.upload_bucket.bucket
}

