terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
      }
    }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "my_bucket" {
    bucket = "classic-bucket-89983212-neww"
    force_destroy = true
  
}

# Enable ACL support (required for public-read)
resource "aws_s3_bucket_ownership_controls" "owner" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "example_bucket_policy" {
    bucket = aws_s3_bucket.my_bucket.id
    policy = jsonencode(
        {
    Version = "2012-10-17",
    Statement = [
        {
            Sid = "PublicReadGetObject",
            Effect = "Allow",
            Principal = "*",
            Action ="s3:GetObject",
            Resource = "arn:aws:s3:::${aws_s3_bucket.my_bucket.id}/*"
        }
    ]
}


    )
}

resource "aws_s3_bucket_website_configuration" "mywebsite_config" {
  bucket = aws_s3_bucket.my_bucket.id

  index_document {
    suffix = "index.html"
  }

}


resource "aws_s3_object" "my_index" {

    bucket = aws_s3_bucket.my_bucket.bucket
    source = "./index.html"
    key = "index.html"
    content_type = "text/html"
    acl = "public-read"

    depends_on = [
    aws_s3_bucket_ownership_controls.owner
  ]
    

  
}

resource "aws_s3_object" "my_style" {
    bucket = aws_s3_bucket.my_bucket.bucket
    source = "./styles.css"
    key = "styles.css"
    content_type = "text/css"
    acl = "public-read"

    depends_on = [
    aws_s3_bucket_ownership_controls.owner
  ]
    
  
}




output "website_link" {
  value = aws_s3_bucket_website_configuration.mywebsite_config.website_endpoint
}
