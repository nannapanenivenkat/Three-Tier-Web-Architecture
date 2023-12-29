resource "aws_iam_role" "Three_tier_Instance_role" {
  name = "Three_tier_Instance_role"
  
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "Three_tier_policy" {
  name        = "Three_tier_policy"
  description = "Policy with specified permissions"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ssm:UpdateInstanceInformation",
        "ssm:ListCommands",
        "ssm:ListCommandInvocations",
        "ssm:ListAssociations",
        "ssm:DescribeInstanceInformation",
        "ssm:DescribeDocument",
        "ssm:GetDocument",
        "ssm:ListDocuments"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:Get*",
        "s3:List*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "example_attachment" {
  role       = aws_iam_role.Three_tier_Instance_role.name
  policy_arn = aws_iam_policy.Three_tier_policy.arn
}
