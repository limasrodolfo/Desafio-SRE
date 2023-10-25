
// Declaração do provider AWS
provider "aws" {
  region = "us-east-1"  # Definição da Região
}

// Bloco que Crição da VPC
resource "aws_vpc" "vpc_desafio" {
  cidr_block           = "10.0.0.0/16" # Range IP que a VPC utilizará. 
  enable_dns_hostnames = true          # Quando definido como true, as instâncias na VPC poderão resolver nomes de domínio em serviços da AWS.
  instance_tenancy     = "default"     # Define que as instâncias lançadas na VPC usarão a tenancy padrão, o que permite que elas compartilhem hardware com outras instâncias da AWS. Você também pode configurá-lo como "dedicated" para instâncias dedicadas, mas isso normalmente tem custos adicionais.
  tags = {
    Name        = "VPC-Desafio" # Essa tag é útil para dar um nome descritivo à VPC.
    Terraformed = "true"        # Define uma segunda tag com a chave "Terraformed" e o valor "true". Isso pode ser usado para rastrear quais recursos foram criados pelo Terraform.
  }
}

// Inicio do Blocos de Criação das Subnets

// Subnet-Publica-A //
resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.vpc_desafio.id # Define a VPC à qual essa sub-rede estará associada.
  cidr_block              = "10.0.1.0/24"          # Define o bloco CIDR da sub-rede pública com 256 endereços IP disponíveis.
  availability_zone       = "us-east-1a"           # Define a zona de disponibilidade da AWS onde esta sub-rede será criada. 
  map_public_ip_on_launch = true                   # Mapear automaticamente endereços IP públicos para instâncias lançadas nesta sub-rede. Com essa configuração, as instâncias na sub-rede poderão acessar a internet diretamente.
  tags = {
    Name = "Subnet-Publica-A" # Identificar e nomear a sub-rede de maneira descritiva.
  }
  depends_on = [
    aws_vpc.vpc_desafio # A criação dessa sub-rede depende da conclusão bem-sucedida da criação da VPC
  ]
}

// Subnet-Publica-B //
resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.vpc_desafio.id # Define a VPC à qual essa sub-rede estará associada.
  cidr_block              = "10.0.2.0/24"          # Define o bloco CIDR da sub-rede pública com 256 endereços IP disponíveis.
  availability_zone       = "us-east-1b"           # Define a zona de disponibilidade da AWS onde esta sub-rede será criada. 
  map_public_ip_on_launch = true                   # Mapear automaticamente endereços IP públicos para instâncias lançadas nesta sub-rede. Com essa configuração, as instâncias na sub-rede poderão acessar a internet diretamente.
  tags = {
    Name = "Subnet-Publica-B" # Identificar e nomear a sub-rede de maneira descritiva.
  }
  depends_on = [
    aws_vpc.vpc_desafio # A criação dessa sub-rede depende da conclusão bem-sucedida da criação da VPC
  ]
}

// Subnet-Privada-A //
resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.vpc_desafio.id # Define a VPC à qual essa sub-rede estará associada.
  cidr_block        = "10.0.3.0/24"          # Define o bloco CIDR da sub-rede pública com 256 endereços IP disponíveis.
  availability_zone = "us-east-1a"           # Define a zona de disponibilidade da AWS onde esta sub-rede será criada. 
  tags = {
    Name = "Subnet-Privada-A" # Identificar e nomear a sub-rede de maneira descritiva.
  }
  depends_on = [
    aws_vpc.vpc_desafio # A criação dessa sub-rede depende da conclusão bem-sucedida da criação da VPC
  ]
}

// Subnet-Privada-B //
resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.vpc_desafio.id # Define a VPC à qual essa sub-rede estará associada.
  cidr_block        = "10.0.4.0/24"          # Define o bloco CIDR da sub-rede pública com 256 endereços IP disponíveis.
  availability_zone = "us-east-1b"           # Define a zona de disponibilidade da AWS onde esta sub-rede será criada.
  tags = {
    Name = "Subnet-Privada-B" # Identificar e nomear a sub-rede de maneira descritiva.
  }
  depends_on = [
    aws_vpc.vpc_desafio # A criação dessa sub-rede depende da conclusão bem-sucedida da criação da VPC
  ]
}

// Fim do Blocos de Criação das Subnets