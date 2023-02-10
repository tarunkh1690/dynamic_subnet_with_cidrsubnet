resource "aws_subnet" "my-private-subnet" {
  count = length(data.aws_availability_zones.available.names)

  cidr_block = cidrsubnet(local.cidr_block, 8, count.index)
  vpc_id     = aws_vpc.myvpc.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = "false" //it makes this a private subnet
  depends_on              = [aws_vpc.myvpc]

  tags =  {
    Name                         = "my-private-subnet-${data.aws_availability_zones.available.names[count.index]}"
    subnet-type                  = "private"
  }
}


resource "aws_subnet" "my-public-subnet" {
  count = length(data.aws_availability_zones.available.names)

  cidr_block = cidrsubnet(local.cidr_block, 8, count.index + length(data.aws_availability_zones.available.names) + 1)
  vpc_id     = aws_vpc.myvpc.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = "true" //it makes this a public subnet
  depends_on              = [aws_vpc.myvpc]

  tags =  {
    Name                         = "my-public-subnet-${data.aws_availability_zones.available.names[count.index]}"
    subnet-type                  = "public"
  }
}