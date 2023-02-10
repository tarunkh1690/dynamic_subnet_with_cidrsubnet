data "aws_availability_zones" "available" {}

data "aws_subnet_ids" "example" {
  vpc_id = aws_vpc.myvpc.id
}

output "subnet_cidr_blocks" {
  #value = [for s in data.aws_subnet.example : s.id]
  value = data.aws_subnet_ids.example.ids
}

data "aws_subnet_ids" "private" {
  vpc_id = aws_vpc.myvpc.id
  filter {
    name = "tag:subnet-type"
    values = ["private"]
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = aws_vpc.myvpc.id
  filter {
    name = "tag:subnet-type"
    values = ["public"]
  }
}

output "private_subnet_cidr_blocks" {
  #value = [for s in data.aws_subnet.example : s.id]
  value = data.aws_subnet_ids.private.ids
}

output "public_subnet_cidr_blocks" {
  #value = [for s in data.aws_subnet.example : s.id]
  value = data.aws_subnet_ids.public.ids
}