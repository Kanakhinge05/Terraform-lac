module "ec2" {
  source = "./MODULES/EC2"

  instance_name    = var.instance_name
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  ssh_cidr         = var.ssh_cidr
  http_cidr        = var.http_cidr
  key_name         = var.key_name

  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
}

module "s3" {
  source = "./MODULES/S3"

  bucket_name = "${var.environment}-bucket-05082002"
  environment = var.environment
}

module "vpc" {
  source = "./MODULES/VPC"

  instance_name = var.instance_name
  environment = var.environment
  vpc_cidr = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone = "${var.aws_region}a"
}
