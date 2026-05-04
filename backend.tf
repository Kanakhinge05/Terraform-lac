terraform {
  backend "s3" {
    bucket = "dev-bucket-05082002"
    key = "project/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    dynamodb_table = "terraform-locks"
  }
}