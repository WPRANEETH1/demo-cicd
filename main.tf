resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    {
      Name        = format("%s-%s", var.vpc_name, "igw"),
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )
}

resource "aws_eip" "nat" {
  count = length(var.public_subnet_cidr_blocks)

  vpc = true
}

resource "aws_nat_gateway" "default" {
  depends_on = [aws_internet_gateway.default]

  count = length(var.public_subnet_cidr_blocks)

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = merge(
    {
      Name        = join("-", [var.vpc_name, "natGW", var.availability_zones_ref[count.index]]),
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )
}

module "s3_uplode" {
  source = "./modules/s3"
}

module "ec2_instance" {
  source = "./modules/ec2"
  ec2_name = "jump-server"
  instance_type = "c5.large"
  vpc_id        = aws_vpc.main.id
  ec2_subnets = aws_subnet.public[*].id
}