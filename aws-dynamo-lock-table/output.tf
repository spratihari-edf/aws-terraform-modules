output "arn" {
  description = "The ARN of the DynamoDB."
  value       = "${aws_dynamodb_table.ddb_table.arn}"
}

output "id" {
  description = "The id of the DynamoDB."
  value       = "${aws_dynamodb_table.ddb_table.id}"
}

