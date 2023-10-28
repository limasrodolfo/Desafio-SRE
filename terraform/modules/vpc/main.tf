// Criação da VPC
resource "aws_vpc" "this" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = "${var.application_name}-vpc"
  }
}

// Criação das Sub-redes
    resource "aws_subnet" "public_subnet_a" {
      vpc_id            = aws_vpc.this.id
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-1a"
      tags = {
        "Name" = "${var.application_name}-public-subnet-A"
      }
    }

    resource "aws_subnet" "public_subnet_b" {
      vpc_id            = aws_vpc.this.id
      cidr_block        = "10.0.2.0/24"
      availability_zone = "us-east-1b"
      tags = {
        "Name" = "${var.application_name}-public-subnet-B"
      }
    }

    resource "aws_subnet" "private_subnet_a" {
      vpc_id            = aws_vpc.this.id
      cidr_block        = "10.0.128.0/24"
      availability_zone = "us-east-1a"
      tags = {
        "Name" = "${var.application_name}-private-subnet-A"
      }
    }

    resource "aws_subnet" "private_subnet_b" {
      vpc_id            = aws_vpc.this.id
      cidr_block        = "10.0.129.0/24"
      availability_zone = "us-east-1b"
      tags = {
        "Name" = "${var.application_name}-private-subnet-B"
      }
    }
// Criação das Sub-redes

// Criação do Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "${var.application_name}-internet-gateway"
  }
}

// Criação de Rotas
resource "aws_route" "this" {
  route_table_id         = aws_route_table.this.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

// Criação de Tabela de Rota
resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "${var.application_name}-route-table"
  }
}

// Associação das sub-redes a Tabela de Rotas
    resource "aws_route_table_association" "public-A" {
      subnet_id      = aws_subnet.public_subnet_a.id
      route_table_id = aws_route_table.this.id
    }

    resource "aws_route_table_association" "public-B" {
      subnet_id      = aws_subnet.public_subnet_b.id
      route_table_id = aws_route_table.this.id
    }

    resource "aws_route_table_association" "private-A" {
      subnet_id      = aws_subnet.private_subnet_a.id
      route_table_id = aws_route_table.this.id
    }

    resource "aws_route_table_association" "private-B" {
      subnet_id      = aws_subnet.private_subnet_b.id
      route_table_id = aws_route_table.this.id
    }
// Associação das sub-redes a Tabela de Rotas