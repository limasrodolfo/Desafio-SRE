# Desafio-SRE
Repositório para desafio SRE - Elven Academy - Wordpress Turbinado 2.0



**Objetivo do Desafio**

Criar um servidor com o site WordPress na AWS de forma automatizada e efetuar o Monitoramento ou Observabilidade com Prometheus.



**Requisitos**

1. Conta válida na AWS

2. Terraform instalado

3. Conhecimento de Ansible

4. Ambiente mínimo de Monitoramento ou Observabilidade



**Passos do Desafio**

- [ ] Provisionar os recursos utilizando o Terraform:

  - [ ] VPC

  - [ ] EC2 

  - [ ] RDS

    Memcached('*')

    EFS ('*')

    Load Balancer ('*')

- [ ] Provisionar no mínimo 2 servidores Linux na AWS;

  Arquitetura com alta disponibilidade multizona; ('*')

- [ ] Instalar e configurar o Wordpress com ansible na EC2;

- [ ] Configurar banco de dados em outro servidor (RDS); 

  Repositório de sessões Memcached em outro servidor; ('*')

  Configurar armazenamento de arquivos escalável e elástico(EFS); ('*')

  Arquitetura elástica com VMs e autoscaling; ('*')

  Arquitetura com CDN/WAF na frente do wordpress; ('*')

  - Cloudflare (https://www.cloudflare.com/pt-br/plans/#overview)
  - Serviço WAF https://aws.amazon.com/pt/waf/pricing/

- [ ] Criar um ambiente mínimo de Monitoramento ou Observabilidade, usando:

  - [ ] Prometheus

    Grafana('*')

    1P('*')

- [ ] Criar indicadores para CPU, Memória, Disco e Request HTTP ou para The Four Golden Signals(Latência, Tráfego, Erros e Saturação).



**('*') Passo opcional.**
