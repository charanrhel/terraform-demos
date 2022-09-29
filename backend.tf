terraform {
  backend "s3" {
    bucket = "rct-buket-create"
    key    = "stage/stage-env.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-state-lock-dynamodb-table"
  }
}


#example url:https://medium.com/dlt-labs-publication/remote-state-and-locking-using-terraform-cff38241a548
#https://jhooq.com/terraform-state-file-locking/

resource "aws_dynamodb_table" "dynamodb" {
name = "terraform-state-lock-dynamodb-table"
hash_key = "LockID"
read_capacity = 10
write_capacity = 10
attribute {
name = "LockID"
type = "S"
}
tags = {
Name = "dynamodb-table-state-lock"
}
}