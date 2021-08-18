provider "aws" {
  region = "ap-south-1"
}

resource "aws_sqs_queue" "my_queue" {
  name                      = "perm-test-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

resource "aws_sqs_queue_policy" "policy" {
  queue_url = aws_sqs_queue.my_queue.id
  policy = <<POLICY
{
   "Version": "2012-10-17",
   "Id": "Default_Policy_UUID",
   "Statement": [{
      "Sid":"Default_AnonymousAccess_ReceiveMessage",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:ReceiveMessage",
      "Resource": "${aws_sqs_queue.my_queue.arn}"
   }]
}
POLICY
}
 
