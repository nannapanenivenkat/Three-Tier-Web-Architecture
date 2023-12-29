resource "aws_s3_bucket" "three_tier_bucket" {
  bucket = "my_three-tier-bucket"



  tags = {
    Name        = "Three_tier_bucket"
    Environment = "Dev"
  }
}


output "s3_bucketname" {
  value = aws_s3_bucket.three_tier_bucket.bucket
}