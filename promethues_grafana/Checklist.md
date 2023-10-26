**Instalação do docker**
video 00:00

sudo amazon-linux-extras install docker
service docker start

**Instalação do prometheus com docker**
vim prometheus.yml

scrape_configs:
 - job_name: 'prometheus'
   scrape_interval:
   static_configs:
     - targets: ['localhost:9090']

docker run -d --rm --network=host -v $(pwd)/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus
docker ps

video 11:15

**Node Export**
mkdir monitor
cd monitor/
wget https:github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
tar xvfz node_exporter-*.*-amd64.tar.gz
./node_exporter

video 17:20

vim prometheus.yml

scrape_configs:
 - job_name: 'prometheus'
   scrape_interval:
   static_configs:
     - targets: ['localhost:9090']

scrape_configs:
 - job_name: 'node-exporter'
   scrape_interval:
   static_configs:
     - targets: ['localhost:9100']

docker ps
docker restart <CONTAINER ID>

**Instalação do grafana com docker**


**Metricas e dashboards**

