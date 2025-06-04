
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "lambda_s3_access" {
  name        = "lambda_s3_access"
  description = "Allow Lambda to access bserverlessbucket S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ],
      Resource = [
        "arn:aws:s3:::bserverlessbucket",
        "arn:aws:s3:::bserverlessbucket/*"
      ]
    }]
  })
}

resource "aws_iam_policy_attachment" "lambda_basic_execution" {
  name       = "lambda-basic-execution"
  roles      = [aws_iam_role.lambda_exec_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy_attachment" "lambda_s3_access_attach" {
  name       = "lambda-s3-access-attach"
  roles      = [aws_iam_role.lambda_exec_role.name]
  policy_arn = aws_iam_policy.lambda_s3_access.arn
}

resource "aws_iam_policy" "ec2_lambda_s3_read_access" {
  name        = "ec2_lambda_s3_read_access"
  description = "EC2 permissions to access Lambda and S3"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:GetBucketPolicy",
          "s3:GetBucketAcl",
          "s3:GetBucketCORS",
          "s3:GetBucketWebsite",
          "s3:GetBucketVersioning",
          "s3:GetAccelerateConfiguration",
          "s3:GetLifecycleConfiguration",
          "s3:GetReplicationConfiguration",
          "s3:GetInventoryConfiguration",
          "s3:GetBucketLogging",
          "s3:GetMetricsConfiguration",
          "s3:GetBucketNotification",
          "s3:GetBucketTagging",
          "s3:GetObjectVersion",
          "s3:GetObjectVersionAcl",
          "s3:GetBucketRequestPayment",
          "s3:GetEncryptionConfiguration" # Required if bucket uses SSE
        ],
        Resource = [
          "arn:aws:s3:::bserverlessbucket",
          "arn:aws:s3:::bserverlessbucket/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "lambda:GetFunction",
          "lambda:ListVersionsByFunction"
        ],
        Resource = "arn:aws:lambda:us-east-1:864899857289:function:S3TriggeredLambda"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_lambda_s3_policy_attach" {
  role       = "Serverless" 
  policy_arn = aws_iam_policy.ec2_lambda_s3_read_access.arn
}

