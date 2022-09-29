data "aws_key_pair" "example" {
#   key_name           = "test"
#   include_public_key = true

  filter {
    name   = "tag:Component"
    values = ["pavan-lab"]
  }
}

output "keys" {
    value = data.aws_key_pair.example.arn
  
}