resource "aws_db_subnet_group" "db_group" {
  name       = "rds_subnet_group"
  description = "subnet group for the database architecture"
  subnet_ids = [aws_subnet.Private_DB_subnet[0].id, aws_subnet.Private_DB_subnet[1].id]
  

  tags = {
    Name = "db_group"
  }
}
           
resource "aws_db_instance" "example" {
  db_name = "Example DB"
  allocated_storage    = 500
  storage_type         = "gp2"
  db_subnet_group_name = aws_db_subnet_group.db_group.id# Copy the subnet group from the RDS Console
  engine               = "aurora"
  engine_version       = "Aurora MySQL 3.03.1"
  identifier           = "aurora-instance-demo"
  instance_class       = "db.r6g.2xlarge"
  multi_az             = false # Custom for SQL Server does support multi-az
  username             = "admin"
  password             = "Welcomedb"
  skip_final_snapshot  = true
  parameter_group_name = "default.aurora-mysql5.7"
  network_type = "IPV4"
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.database_sg.id]

  tags = {
    Name = "Example DB"
  }

}

output "rds_endpoint" {
  value = aws_db_instance.example.endpoint
}

output "rds_username" {
  value = aws_db_instance.example.username
}