resource "aws_db_subnet_group" "db_group" {
  name       = "rds_subnet_group"
  subnet_ids = [aws_subnet.public_subnet[0].id, aws_subnet.public_subnet[1].id]

  tags = {
    Name = "db_group"
  }
}
           
resource "aws_db_instance" "example" {
  allocated_storage    = 500
  storage_type         = "gp2"
  db_subnet_group_name = aws_db_subnet_group.db_group.id# Copy the subnet group from the RDS Console
  engine               = "mysql"
  engine_version       = "5.7"
  identifier           = "sql-instance-demo"
  instance_class       = "db.t2.micro"
  multi_az             = false # Custom for SQL Server does support multi-az
  username             = "foo"
  password             = "foobarbaz"
  skip_final_snapshot  = true
  parameter_group_name = "default.mysql5.7"

}