// Inicio do Bloco de Crição da VPC
resource "aws_vpc" "this" {
  cidr_block           = "10.0.0.0/16" # CIDR classe B 
  enable_dns_hostnames = true          # Quando definido como true, as instâncias na VPC poderão resolver nomes de domínio em serviços da AWS.
  instance_tenancy     = "default"     # Define que as instâncias lançadas na VPC usarão a tenancy padrão, o que permite que elas compartilhem hardware com outras instâncias da AWS. Você também pode configurá-lo como "dedicated" para instâncias dedicadas, mas isso normalmente tem custos adicionais.
  tags = {
    Name        = "VPC-Desafio" # Essa tag é útil para dar um nome descritivo à VPC.
    Terraformed = "true"        # Define uma segunda tag com a chave "Terraformed" e o valor "true". Isso pode ser usado para rastrear quais recursos foram criados pelo Terraform.
  }
}
// Fim do Bloco de Criação da VPC

// Inicio do Blocos de Criação das Subnets
// Subnet-Publica-A //
resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.this.id        # Define a VPC à qual essa sub-rede estará associada.
  cidr_block              = "10.0.1.0/24"          # Define o bloco CIDR da sub-rede pública com 256 endereços IP disponíveis.
  availability_zone       = "us-east-1a"           # Define a zona de disponibilidade da AWS onde esta sub-rede será criada. 
  map_public_ip_on_launch = true                   # Mapear automaticamente endereços IP públicos para instâncias lançadas nesta sub-rede. Com essa configuração, as instâncias na sub-rede poderão acessar a internet diretamente.
  tags = {
    Name = "Subnet-Publica-A-Desafio" # Identificar e nomear a sub-rede de maneira descritiva.
  }
  depends_on = [
    aws_vpc.this # A criação dessa sub-rede depende da conclusão bem-sucedida da criação da VPC
  ]
}

// Subnet-Publica-B //
resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.this.id        # Define a VPC à qual essa sub-rede estará associada.
  cidr_block              = "10.0.2.0/24"          # Define o bloco CIDR da sub-rede pública com 256 endereços IP disponíveis.
  availability_zone       = "us-east-1b"           # Define a zona de disponibilidade da AWS onde esta sub-rede será criada. 
  map_public_ip_on_launch = true                   # Mapear automaticamente endereços IP públicos para instâncias lançadas nesta sub-rede. Com essa configuração, as instâncias na sub-rede poderão acessar a internet diretamente.
  tags = {
    Name = "Subnet-Publica-B-Desafio" # Identificar e nomear a sub-rede de maneira descritiva.
  }
  depends_on = [
    aws_vpc.this # A criação dessa sub-rede depende da conclusão bem-sucedida da criação da VPC
  ]
}

// Subnet-Privada-A //
resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.this.id        # Define a VPC à qual essa sub-rede estará associada.
  cidr_block        = "10.0.3.0/24"          # Define o bloco CIDR da sub-rede pública com 256 endereços IP disponíveis.
  availability_zone = "us-east-1a"           # Define a zona de disponibilidade da AWS onde esta sub-rede será criada. 
  tags = {
    Name = "Subnet-Privada-A-Desafio" # Identificar e nomear a sub-rede de maneira descritiva.
  }
  depends_on = [
    aws_vpc.this # A criação dessa sub-rede depende da conclusão bem-sucedida da criação da VPC
  ]
}

// Subnet-Privada-B //
resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.this.id        # Define a VPC à qual essa sub-rede estará associada.
  cidr_block        = "10.0.4.0/24"          # Define o bloco CIDR da sub-rede pública com 256 endereços IP disponíveis.
  availability_zone = "us-east-1b"           # Define a zona de disponibilidade da AWS onde esta sub-rede será criada.
  tags = {
    Name = "Subnet-Privada-B" # Identificar e nomear a sub-rede de maneira descritiva.
  }
  depends_on = [
    aws_vpc.this # A criação dessa sub-rede depende da conclusão bem-sucedida da criação da VPC
  ]
}
// Fim do Blocos de Criação das Subnets

//Inicio do Bloco de Cria Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this

  tags = {
    Name = "Internet-Gateway-Desafio",
    terraformed = "true"
  }
  depends_on = [
    aws_vpc.this
  ]
}
//Fim do Bloco de Cria Internet Gateway

//Inicio do Bloco de Criação IPs dos Nat Gateways
resource "aws_eip" "eip-a" {
  vpc      = true
  tags = {
    Name = "IPS-Internet-Gateway-A-Desafio",
    terraformed = "true"
  }
  depends_on = [
    aws_vpc.this,
    aws_internet_gateway.this
  ]
}

resource "aws_eip" "eip-b" {
  vpc      = true
  tags = {
    Name = "IPS-Internet-Gateway-B-Desafio",
    terraformed = "true"
  }
  depends_on = [
    aws_vpc.this,
    aws_internet_gateway.this
  ]
}
//Fim do Bloco de Criação IPs dos Nat Gateways

//Inicio do Bloco de Criação dos Nat Gateways
resource "aws_nat_gateway" "nat_gateway_a" {
  allocation_id = aws_eip.eip-a.id
  subnet_id     = aws_subnet.public_subnet_a

  tags = {
    Name = "Nat-Gateway-A-Desafio",
    terraformed = "true"
  }
  depends_on = [
    aws_vpc.this,
    aws_internet_gateway.this,
    aws_eip.eip-a
  ]
}

resource "aws_nat_gateway" "nat_gateway_b" {
  allocation_id = aws_eip.eip-b.id
  subnet_id     = aws_subnet.public_subnet_b

  tags = {
    Name = "Nat-Gateway-B-Desafio",
    terraformed = "true"
  }
  depends_on = [
    aws_vpc.this,
    aws_internet_gateway.this,
    aws_eip.eip-b
  ]
}
//Fim do Bloco de Criação dos Nat Gateways

//Inicio do Bloco de Criação da Tabelas de Roteamento
// Tabela-Publica-A //
resource "aws_route_table" "public_route_table_a" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "Public-Route-Table-A-Desafio",
    terraformed = "true"
  }
  depends_on = [
    aws_vpc.this,
    aws_internet_gateway.this
  ]
}

// Tabela-Publica-B //
resource "aws_route_table" "public_route_table_b" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "Public-Route-Table-B-Desafio",
    terraformed = "true"
  }
  depends_on = [
    aws_vpc.this,
    aws_internet_gateway.this
  ]
}

// Tabela-Privada-A //
resource "aws_route_table" "private_route_table_a" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "Private-Route-Table-A-Desafio",
    terraformed = "true"
  }
  depends_on = [
    aws_vpc.this,
    aws_internet_gateway.this
  ]
}

// Tabela-Privada-B //
resource "aws_route_table" "private_route_table_b" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "Public-Route-Table-B-Desafio",
    terraformed = "true"
  }
  depends_on = [
    aws_vpc.this,
    aws_internet_gateway.this
  ]
}
//Fim do Bloco de Criação da Tabelas de Roteamento

//Inicio do Bloco de Associação da Tabelas de Roteamento
// Associação-Publica-A //
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_route_table_a.id
}

// Associação-Publica-B //
resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_route_table_b.id
}

// Associação-Privada-A //
resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_route_table_a.id
}

// Associação-Privada-B //
resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_route_table_b.id
}
//Fim do Bloco de associação da Tabelas de Roteamento