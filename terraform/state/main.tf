terraform {
  required_version = "~> 0.10.4"

  backend "s3" {
    // Searches for the following profile in ~/.aws/credentials
    profile = "julioprotzek"
    region = "sa-east-1"
    bucket = "terraform-nanofile-state"
    key    = "global/s3/terraform.tfstate"
  }
}

provider "aws" {
  version = "~> 0.1.0"

  // Searches for the following profile in ~/.aws/credentials
  profile = "julioprotzek"
  region = "sa-east-1"
}


resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-nanofile-state"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket" "uploads" {
  bucket = "nanofile-temp-uploads"
  acl    = "public-read"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "DELETE"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }
}
