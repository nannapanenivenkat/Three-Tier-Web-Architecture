resource "aws_s3_bucket" "Three_tier_bucket" {
  bucket = "Three-tier-bucket"



  tags = {
    Name        = "Three_tier_bucket"
    Environment = "Dev"
  }
}


output "s3_bucketname" {
  value = aws_s3_bucket.Three_tier_bucket.bucket
}