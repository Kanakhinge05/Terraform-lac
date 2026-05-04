output "id" {
    description = "The ID of the created EC2 instance"
    value = module.ec2.id
}

output "public_ip" {
    description = "The public IPs of the created EC2 instances"
    value = module.ec2.public_ip
}

output "public_dns" {
    description = "The public DNS of the created EC2 instance"
    value = module.ec2.public_dns
}

output "vpc_id" {
    description = "The ID of the created VPC"
    value = module.vpc.vpc_id
}
