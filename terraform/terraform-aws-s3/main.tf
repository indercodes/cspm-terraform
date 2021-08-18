provider "aws" {
  region = "ap-south-1"
}


resource "aws_s3_bucket" "bucket" {
  bucket = "my-tf-bucket-perm-test"
  acl    = "private"
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:DeleteObject",
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Principal": "*",
      "Resource": "${aws_s3_bucket.bucket.arn}/*" 
    }
  ]
}
EOT
}
