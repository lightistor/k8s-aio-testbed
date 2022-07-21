# `KinD` Cluster for `Pulsar Function` Testing Setup  (`CentOS 8` w/ `Bourne Again Shell/.bash`)

# Index

# Preparation

### **Primary Environment Variables**
```bash
KIND_VM_IP=10.70.5.21
```

### **Directories Setup**
```bash
mkdir -p /home/admin/app/cicd/challenges/KinD/deploy/xperiment/kind-k8s/gnu/config
mkdir -p /home/admin/app/cicd/challenges/KinD/deploy/xperiment/kind-k8s/gnu/platform-test-app
mkdir -p /home/admin/app/helm-local
mkdir -p /home/admin/stage/pulsar-runtime
mkdir -p /home/admin/bin-temp
```

### **kubectl CLI Tool Installation on Cluster VM**
```bash
mkdir -p /home/admin/util/kubectl/v1.23.0/bin
curl -Lo /home/admin/bin-temp/kubectl-linux-amd64 https://dl.k8s.io/release/v1.23.0/bin/linux/amd64/kubectl
mv /home/admin/bin-temp/kubectl-linux-amd64  /home/admin/util/kubectl/v1.23.0/bin/kubectl
chmod +x /home/admin/util/kubectl/v1.23.0/bin/kubectl
sh -c 'cat << EOF >> /home/admin/.bashrc
K8SCTL_HOME=/home/admin/util/kubectl/v1.23.0
PATH=\$K8SCTL_HOME/bin:\$PATH
EOF'
source /home/admin/.bashrc
```

### **KinD CLI Tool Installation**
```bash
mkdir -p /home/admin/util/kind/v0.12.0/bin
curl -Lo /home/admin/bin-temp/kind-linux-amd64 https://github.com/kubernetes-sigs/kind/releases/download/v0.12.0/kind-linux-amd64
mv /home/admin/bin-temp/kind-linux-amd64 /home/admin/util/kind/v0.12.0/bin/kind
chmod +x /home/admin/util/kind/v0.12.0/bin/kind
sh -c 'cat << EOF >> /home/admin/.bashrc
KIND_HOME=/home/admin/util/kind/v0.12.0
PATH=\$KIND_HOME/bin:\$PATH
EOF'
source /home/admin/.bashrc
docker pull kindest/node:v1.23.4
```

### **Helm CLI Tool Installation**
```bash
mkdir -p /home/admin/util/helm/v3.4.1/bin
curl -Lo /home/admin/bin-temp/helm-v3.4.1-linux-amd64.tar.gz https://get.helm.sh/helm-v3.4.1-linux-amd64.tar.gz
tar -xf /home/admin/bin-temp/helm-v3.4.1-linux-amd64.tar.gz -C /home/admin/util/helm/v3.4.1
mv /home/admin/util/helm/v3.4.1/linux-amd64/helm /home/admin/util/helm/v3.4.1/bin/helm
chmod +x /home/admin/util/helm/v3.4.1/bin/helm
rm /home/admin/helm-v3.4.1-linux-amd64.tar.gz
rm -rf /home/admin/util/helm/v3.4.1/linux-amd64
sh -c 'cat << EOF >> /home/admin/.bashrc
HELM_HOME=/home/admin/util/helm/v3.4.1
PATH=\$HELM_HOME/bin:\$PATH
EOF'
source /home/admin/.bashrc
```

### **Pulsar CLI Installation**
```bash
mkdir -p /home/admin/util/pulsar/v2.9.1
curl -Lo /home/admin/bin-temp/apache-pulsar-v2.9.1-bin.tar.gz https://archive.apache.org/dist/pulsar/pulsar-2.9.1/apache-pulsar-2.9.1-bin.tar.gz

tar -xf /home/admin/bin-temp/apache-pulsar-v2.9.1-bin.tar.gz -C /home/admin/util/pulsar/v2.9.1
mv /home/admin/util/pulsar/v2.9.1/apache-pulsar-2.9.1/* /home/admin/util/pulsar/v2.9.1/
rm -rf /home/admin/util/pulsar/v2.9.1/apache-pulsar-2.9.1
sh -c 'cat << EOF >> /home/admin/.bashrc
PULSAR_HOME=/home/admin/util/pulsar/v2.9.1
PATH=\$PULSAR_HOME/bin:\$PATH
EOF'
source /home/admin/.bashrc
```

### (Required-for-DevGitOps) **ArgoCD CLI Installation**
```bash
mkdir -p /home/admin/util/argocd/v2.4.3/bin
curl -Lo /home/admin/bin-temp/argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/download/v2.4.3/argocd-linux-amd64
mv /home/admin/bin-temp/argocd-linux-amd64  /home/admin/util/argocd/v2.4.3/bin/argocd
chmod +x /home/admin/util/argocd/v2.4.3/bin/argocd
sh -c 'cat << EOF >> /home/admin/.bashrc
ARGOCDCLI_HOME=/home/admin/util/argocd/v2.4.3
PATH=\$ARGOCDCLI_HOME/bin:\$PATH
EOF'
```

### **JDK Installlation for Java 11**
```bash
# Java 1.8
# sudo dnf install java-1.8.0-openjdk
# sudo dnf install java-11-openjdk
mkdir -p /home/admin/util/openjdk/11/1.11.28
curl -Lo /home/admin/bin-temp/openjdk-11+28_linux-x64_bin.tar.gz https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz

tar -xf /home/admin/bin-temp/openjdk-11+28_linux-x64_bin.tar.gz -C /home/admin/util/openjdk/11/1.11.28
mv /home/admin/util/openjdk/11/1.11.28/jdk-11/* /home/admin/util/openjdk/11/1.11.28/
rm -rf /home/admin/util/openjdk/11/1.11.28/jdk-11
sh -c 'cat << EOF >> /home/admin/.bashrc
JAVA_HOME=/home/admin/util/openjdk/11/1.11.28
PATH=\$JAVA_HOME/bin:\$PATH
EOF'
source /home/admin/.bashrc
```

### **Maven Installation**
```bash
mkdir -p /home/admin/util/maven/3.8.5
curl -Lo /home/admin/bin-temp/apache-maven-3.8.5-bin.tar.gz https://dlcdn.apache.org/maven/maven-3/3.8.5/binaries/apache-maven-3.8.5-bin.tar.gz

tar -xf /home/admin/bin-temp/apache-maven-3.8.5-bin.tar.gz -C /home/admin/util/maven/3.8.5
mv /home/admin/util/maven/3.8.5/apache-maven-3.8.5/* /home/admin/util/maven/3.8.5/
rm -rf /home/admin/util/maven/3.8.5/apache-maven-3.8.5
sh -c 'cat << EOF >> /home/admin/.bashrc
MVN_HOME=/home/admin/util/maven/3.8.5
PATH=\$MVN_HOME/bin:\$PATH
EOF'
source /home/admin/.bashrc
```

### **Baseline IaC Descriptor Definitions**

#### KinD Cluster Configuration & Validation
```bash
# Write KinD config .yaml
sh -c 'cat << EOF > /home/admin/app/cicd/challenges/KinD/deploy/xperiment/kind-k8s/gnu/config/kind-config.yaml
# four node (three workers) cluster config
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: 38180
    hostPort: 8080
    protocol: TCP
- role: worker
- role: worker
- role: worker
EOF' 

# Validate - KinD config .yaml
cat /home/admin/app/cicd/challenges/KinD/deploy/xperiment/kind-k8s/gnu/config/kind-config.yaml
```
#### MetalLB Manifests Download & Configmap Setup
```bash
# Retrieve MetalLB K8s Resources manifest .yaml
curl -Lo /home/admin/app/cicd/challenges/KinD/deploy/xperiment/kind-k8s/gnu/config/metallb.yaml https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/metallb.yaml

# Write MetalLB configmap .yaml
sh -c 'cat << EOF > /home/admin/app/cicd/challenges/KinD/deploy/xperiment/kind-k8s/gnu/config/kind-metallb-configmap-base.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: docker-nix-server
      protocol: layer2
      addresses:
      - #NET_DOCKER_CLASSC#.200-#NET_DOCKER_CLASSC#.250
EOF'
```

#### KinD Cluster Node Metric Exporter Setup & Configuration
```bash
# Write Node Metric Exporter config .yaml
sh -c 'cat << EOF > /home/admin/app/cicd/challenges/KinD/deploy/xperiment/kind-k8s/gnu/config/ndxptr-dset-config.yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  labels:
    app.kubernetes.io/component: exporter
    app.kubernetes.io/name: node-exporter
  name: node-exporter
  namespace: monitoring
spec:
  selector:
    matchLabels:
      app.kubernetes.io/component: exporter
      app.kubernetes.io/name: node-exporter
  template:
    metadata:
      labels:
        app.kubernetes.io/component: exporter
        app.kubernetes.io/name: node-exporter
    spec:
      containers:
      - args:
        - --path.sysfs=/host/sys
        - --path.rootfs=/host/root
        - --no-collector.wifi
        - --no-collector.hwmon
        - --collector.filesystem.ignored-mount-points=^/(dev|proc|sys|var/lib/docker/.+|var/lib/kubelet/pods/.+)($|/)
        - --collector.netclass.ignored-devices=^(veth.*)$
        name: node-exporter
        image: prom/node-exporter
        ports:
          - containerPort: 9100
            protocol: TCP
        resources:
          limits:
            cpu: 250m
            memory: 360Mi
          requests:
            cpu: 125m
            memory: 180Mi
        volumeMounts:
        - mountPath: /host/sys
          mountPropagation: HostToContainer
          name: sys
          readOnly: true
        - mountPath: /host/root
          mountPropagation: HostToContainer
          name: root
          readOnly: true
      volumes:
      - hostPath:
          path: /sys
        name: sys
      - hostPath:
          path: /
        name: root
EOF' 

# Validate - Node Metric Exporter config .yaml
# [WIP]
```
## MetalLB - Access Integration Test Service Descriptor Definitions
```bash
# Write - MetalLB Basic Access Integration - Deployment
sh -c 'cat << EOF > /home/admin/app/cicd/challenges/KinD/deploy/xperiment/kind-k8s/gnu/platform-test-app/metallb-dryrun-nginx-app-deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
  namespace: mtllb-int-test
spec:
  selector:
    matchLabels:
      app: l-mtllb-int-nginx
  template:
    metadata:
      labels:
        app: l-mtllb-int-nginx
    spec:
      containers:
      - name: c-mtllb-int-nginx
        image: nginx:1
        ports:
        - name: http
          containerPort: 80
EOF'

# Write - MetalLB Basic Access Integration - Service
sh -c 'cat << EOF > /home/admin/app/cicd/challenges/KinD/deploy/xperiment/kind-k8s/gnu/platform-test-app/metallb-dryrun-nginx-app-svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: mtllb-int-nginx
  namespace: mtllb-int-test
  annotations:
    metallb.universe.tf/address-pool: docker-nix-server
spec:
  ports:
  - name: http
    port: 48080
    protocol: TCP
    targetPort: 80
  selector:
    app: l-mtllb-int-nginx
  type: LoadBalancer
EOF'
```

# Platform Setup

## Setup KinD Cluster
```bash
kind create cluster --name kind-pg-0 --config /home/admin/app/cicd/challenges/KinD/deploy/xperiment/kind-k8s/gnu/config/kind-config.yaml

kubectl cluster-info --context kind-kind-pg-0

kubectl get service --all-namespaces --context kind-kind-pg-0
```

## Setup MetalLB
### Pre-Requisite
```bash
sysctl -w fs.inotify.max_user_watches=512000
sysctl -w fs.inotify.max_user_instances=512000
```

```bash
# Apply MetalLB Manifest
kubectl create ns metallb-system --context kind-kind-pg-0
kubectl apply --context kind-kind-pg-0 -f /home/admin/app/cicd/challenges/KinD/deploy/xperiment/kind-k8s/gnu/config/metallb.yaml
# * Clean-up
# ** kubectl delete --context kind-kind-pg-0 -f /home/admin/app/cicd/challenges/KinD/deploy/xperiment/kind-k8s/gnu/config/metallb.yaml
kubectl get pods -n metallb-system --context kind-kind-pg-0 --watch

# Get IP Address
NET_DOCKER_CLASSC=$(docker network inspect kind -f "{{(index .IPAM.Config 0).Subnet}}" | cut -d '.' -f1,2)".255"
#NET_DOCKER_CLASSC="10.70.5"
sed -e "s/#NET_DOCKER_CLASSC#/$NET_DOCKER_CLASSC/g" /home/admin/app/cicd/challenges/KinD/deploy/xperiment/kind-k8s/gnu/config/kind-metallb-configmap-base.yaml > /home/admin/app/cicd/challenges/KinD/deploy/xperiment/kind-k8s/gnu/config/kind-metallb-configmap.yaml
# Apply MetalLB ConfigMap
kubectl apply --context kind-kind-pg-0 -f /home/admin/app/cicd/challenges/KinD/deploy/xperiment/kind-k8s/gnu/config/kind-metallb-configmap.yaml
```

## MetalLB - Basic Integration Test - Service Setup & Validation
```bash
kubectl create ns mtllb-int-test --context kind-kind-pg-0
kubectl apply --context kind-kind-pg-0 -f /home/admin/app/cicd/challenges/KinD/deploy/xperiment/kind-k8s/gnu/platform-test-app/metallb-dryrun-nginx-app-deploy.yaml
kubectl apply --context kind-kind-pg-0 -f /home/admin/app/cicd/challenges/KinD/deploy/xperiment/kind-k8s/gnu/platform-test-app/metallb-dryrun-nginx-app-svc.yaml

#kubectl get deploy --all-namespaces --context kind-kind-pg-0
#kubectl get service --all-namespaces --context kind-kind-pg-0
kubectl get deploy -n mtllb-int-test --context kind-kind-pg-0
kubectl get service -n mtllb-int-test --context kind-kind-pg-0

# INTERNAL CHECK
TEST_SVC_LBIP=$(kubectl get service --context kind-kind-pg-0 -n mtllb-int-test mtllb-int-nginx -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')

#kubectl get service --context kind-kind-pg-0 -n mtllb-int-test mtllb-int-nginx -o=jsonpath='{.spec.ports[?(@.name=="http")].port}'
#kubectl get service --context kind-kind-pg-0 -n mtllb-int-test mtllb-int-nginx -o=jsonpath='{.spec.ports[?(@.name=="http")].nodePort}'
#kubectl get service --context kind-kind-pg-0 -n mtllb-int-test mtllb-int-nginx -o=jsonpath='{.spec.ports[0].port}'
TEST_SVC_LBPORT=$(kubectl get service --context kind-kind-pg-0 -n mtllb-int-test mtllb-int-nginx -o=jsonpath='{.spec.ports[0].port}')

echo $TEST_SVC_LBIP
echo $TEST_SVC_LBPORT

curl $TEST_SVC_LBIP:$TEST_SVC_LB_PORT

# EXTERNAL CHECK - SETUP PORT-FORWARD for Service
TEST_SVC_LBPORT=$(kubectl get service --context kind-kind-pg-0 -n mtllb-int-test mtllb-int-nginx -o=jsonpath='{.spec.ports[0].port}')
TEST_SVC_XTFWPORT=48080
kubectl port-forward service/mtllb-int-nginx --address 0.0.0.0 -n mtllb-int-test $TEST_SVC_XTFWPORT:$TEST_SVC_LBPORT --context kind-kind-pg-0 > /dev/null 2>&1 &

# Access Host LB_IP:tcp_port
# [WIP] - Missing Validation
curl $KIND_VM_IP:$TEST_SVC_XTFWPORT

# Stop Port-Forwarding for MetalLB Test Service
ps aux | grep -i kubectl | grep -v grep | grep -e "port-forward service/mtllb-int-nginx --address 0.0.0.0 -n mtllb-int-test $TEST_SVC_XTFWPORT:$TEST_SVC_LBPORT --context kind-kind-pg-0" | awk {'print $2'} | xargs kill
```

## [WIP] Install `Node Exporter` on `KinD` Cluster
```bash
helm repo add bitnami/redis https://pulsar.apache.org/charts && helm repo update

```

## Install `Redis` Cluster
```bash
helm repo add bitnami https://charts.bitnami.com/bitnami

kubectl create ns pulsar-sink-redis --context kind-kind-pg-0
helm install pulsar-sink-redis bitnami/redis-cluster \
    --namespace pulsar-sink-redis \
    --set global.redis.password=redispass \
    --atomic

kubectl get svc pulsar-sink-redis-redis-cluster -n pulsar-sink-redis --context kind-kind-pg-0 -o yaml

kubectl patch svc pulsar-sink-redis-redis-cluster -n pulsar-sink-redis --context kind-kind-pg-0 -p '{"metadata":{"annotations":{"metallb.universe.tf/address-pool": "docker-nix-server"}}, "spec": {"type": "LoadBalancer"}}'

PLSR_SNK_RDS_SVC_LBPORT=$(kubectl get service --context kind-kind-pg-0 -n pulsar-sink-redis pulsar-sink-redis-redis-cluster -o=jsonpath='{.spec.ports[0].port}')
PLSR_SNK_RDS_SVC_XTFWPORT=46379
kubectl port-forward service/pulsar-sink-redis-redis-cluster --address 0.0.0.0 -n pulsar-sink-redis $PLSR_SNK_RDS_SVC_XTFWPORT:$PLSR_SNK_RDS_SVC_LBPORT --context kind-kind-pg-0

PULSAR_SINK_REDIS_PASS=$(kubectl get secret pulsar-sink-redis-redis-cluster -n pulsar-sink-redis -o jsonpath="{.data.redis-password}" | base64 --decode)

#kubectl run pulsar-sink-redis-cluster-client --rm --tty -i --restart='Never' --namespace pulsar-sink-redis --context kind-kind-pg-0 --env REDIS_PASSWORD=$PULSAR_SINK_REDIS_PASS --image docker.io/bitnami/redis-cluster:6.2.6-debian-10-r174 -- bash

kubectl run pulsar-sink-redis-cluster-client --namespace pulsar-sink-redis --context kind-kind-pg-0 --restart="Never" --env REDIS_PASSWORD=$PULSAR_SINK_REDIS_PASS --image docker.io/bitnami/redis:6.2.6-debian-10-r174 --command -- sleep infinity

```

## `Pulsar Runtime` Installation
```bash
sh -c 'cat << EOF > /home/admin/stage/pulsar-runtime/prep-pulsar-chart.sh
#!/bin/bash
if [ -d "/home/admin/app/helm-local/pulsar-helm-chart" ]
then
    rm -rf /home/admin/app/helm-local/pulsar-helm-chart
else
    mkdir -p /home/admin/app/helm-local/pulsar-helm-chart
    git clone https://github.com/apache/pulsar-helm-chart /home/admin/app/helm-local/pulsar-helm-chart
fi

sh /home/admin/app/helm-local/pulsar-helm-chart/scripts/pulsar/prepare_helm_release.sh \
-n pulsar \
-k pulsar-mini \
-l \
-c

EOF'

sh /home/admin/stage/pulsar-runtime/prep-pulsar-chart.sh

helm repo add apache https://pulsar.apache.org/charts && helm repo update

# [TODO] Retrieve tags from retrieved chart values.yaml for docker container images
docker pull apachepulsar/pulsar-all:2.9.2
docker pull streamnative/apache-pulsar-grafana-dashboard-k8s:0.0.16
docker pull prom/prometheus:v2.17.2
docker pull apachepulsar/pulsar-manager:v0.2.0
# * Load from local tarball instead of local docker for ansible remote hosts
# kind load --name kind-pg-0 image-archive $KIND_CNT_IMG_DIR/apachepulsar-pulsar_-_all-2.9.2.tar.gz
kind load --name kind-pg-0 docker-image apachepulsar/pulsar-all:2.9.2
kind load --name kind-pg-0 docker-image streamnative/apache-pulsar-grafana-dashboard-k8s:0.0.16
kind load --name kind-pg-0 docker-image prom/prometheus:v2.17.2
kind load --name kind-pg-0 docker-image apachepulsar/pulsar-manager:v0.2.0

# [TODO] Valida Image update to KinD nodes through the output
docker exec -it kind-pg-0-control-plane bash -c 'crictl images'
# docker exec -it kind-pg-0-worker bash -c 'crictl images'
# docker exec -it kind-pg-0-worker-2 bash -c 'crictl images'
# docker exec -it kind-pg-0-worker-3 bash -c 'crictl images'

kubectl create ns pulsar --context kind-kind-pg-0
helm install pulsar-mini \
    /home/admin/app/helm-local/pulsar-helm-chart/charts/pulsar \
    --values /home/admin/app/helm-local/pulsar-helm-chart/examples/values-minikube.yaml \
    --set initialize=true \
    --namespace pulsar \
    --atomic

# _TOTAL=$(kubectl get pods -n pulsar | grep -v "\-init\-" | grep -v "NAME.*READY.*STATUS.*RESTARTS.*AGE")
# [WIP], #replica > 1 should be calculated
# _READY=$(kubectl get pods -n pulsar | grep -v "\-init\-" | grep -v "NAME.*READY.*STATUS.*RESTARTS.*AGE" | awk '{print $2}' | grep -v "0\/" | wc -l)

kubectl get pods -n pulsar
kubectl get services -n pulsar
```

## Prepare `Pulsar Runtime` via `pulsar-admin` CLI in `pulsar-toolset` pod for Sanity Check
```bash
# * kubectl exec -ti -n pulsar pulsar-mini-toolset-0 -- bash -c "bin/pulsar-admin tenants list"

# Create Pulsar Tenant: apache
kubectl exec -it -n pulsar pulsar-mini-toolset-0 -- /bin/bash -c "bin/pulsar-admin tenants create apache"
kubectl exec -it -n pulsar pulsar-mini-toolset-0 -- /bin/bash -c "bin/pulsar-admin tenants list"
# Create Pulsar Namespace in Tenant apache: pulsar
kubectl exec -it -n pulsar pulsar-mini-toolset-0 -- /bin/bash -c "bin/pulsar-admin namespaces create apache/pulsar"
kubectl exec -it -n pulsar pulsar-mini-toolset-0 -- /bin/bash -c "bin/pulsar-admin namespaces list apache"
# Create Partitioned Topic with 4 partitions: apache/pulsar/test-topic
kubectl exec -it -n pulsar pulsar-mini-toolset-0 -- /bin/bash -c "bin/pulsar-admin topics create-partitioned-topic apache/pulsar/test-topic -p 4"
kubectl exec -it -n pulsar pulsar-mini-toolset-0 -- /bin/bash -c "bin/pulsar-admin topics list-partitioned-topics apache/pulsar"

# Get LB IP & Port for WebService
PULSAR_WS_URL=$(kubectl get service --context kind-kind-pg-0 -n pulsar pulsar-mini-proxy -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')
PULSAR_WS_PORT=$(kubectl get service --context kind-kind-pg-0 -n pulsar pulsar-mini-proxy -o=jsonpath='{.spec.ports[0].port}')
# Get LB IP & Port for BrokerService
PULSAR_BRS_URL=$(kubectl get service --context kind-kind-pg-0 -n pulsar pulsar-mini-proxy -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')
PULSAR_BRS_PORT=$(kubectl get service --context kind-kind-pg-0 -n pulsar pulsar-mini-proxy -o=jsonpath='{.spec.ports[1].port}')

cp ${PULSAR_HOME}/conf/client.conf ${PULSAR_HOME}/conf/client.conf.BAK

WS_URL_TLS_LINE=$(grep "#\ webServiceUrl" ${PULSAR_HOME}/conf/client.conf | cut -d '=' -f2)
sed -i -e "s/webServiceUrl\=.*/webServiceUrl\=http\:\/\/$PULSAR_WS_URL\:$PULSAR_WS_PORT\//g" ${PULSAR_HOME}/conf/client.conf
sed -i -e "s|\#\ webServiceUrl\=.*|\#\ webServiceUrl\=$WS_URL_TLS_LINE|g" ${PULSAR_HOME}/conf/client.conf
sed -i -e "s/brokerServiceUrl\=pulsar\:\/\/.*/brokerServiceUrl\=pulsar\:\/\/$PULSAR_BRS_URL\:$PULSAR_BRS_PORT\//g" ${PULSAR_HOME}/conf/client.conf
```

## Execute `Pulsar Runtime` Sanity Check via `pulsar-client` CLI in `pulsar-toolset` pod
```bash

kubectl exec -it -n pulsar pulsar-mini-toolset-0 -- /bin/bash -c "bin/pulsar-client consume -s sub apache/pulsar/test-topic -n 0"  > /dev/null 2>&1 &

kubectl exec -it -n pulsar pulsar-mini-toolset-0 -- /bin/bash -c 'bin/pulsar-client produce apache/pulsar/test-topic  -m "--- hello apache pulsar in KinD ---" -n 1000'

ps aux | grep -i kubectl | grep -v grep | grep -e "-n pulsar pulsar-mini-toolset-0.*bin/pulsar-client consume -s sub apache/pulsar/test-topic -n 0" | awk {'print $2'} | xargs kill

cp ${PULSAR_HOME}/conf/client.conf.BAK ${PULSAR_HOME}/conf/client.conf
```

## `(Optional*)` Access `Pulsar Manager` `#Board` in `KinD` cluster for `Pulsar Runtime`
```bash
# * Helm Chart from Pulsar Github repo or Helm Repo did not onboard Pulsar Manager
PLSR_MNGR_SVC_LBPORT=$(kubectl get service --context kind-kind-pg-0 -n pulsar pulsar-mini-manager -o=jsonpath='{.spec.ports[0].port}')
PLSR_MNGR_SVC_XTFWPORT=47750

kubectl port-forward service/pulsar-mini-manager --address 0.0.0.0 -n pulsar $PLSR_MNGR_SVC_XTFWPORT:$PLSR_MNGR_SVC_LBPORT --context kind-kind-pg-0

```

## `(Optional)` Access `Grafana` in `KinD` cluster within the same namespace as `Pulsar Runtime`
```bash
PLSR_GRFN_SVC_LBPORT=$(kubectl get service --context kind-kind-pg-0 -n pulsar pulsar-mini-grafana -o=jsonpath='{.spec.ports[0].port}')
PLSR_GRFN_SVC_XTFWPORT=43000
# Start Port-Forwarding for Pulsar Runtime Grafana
kubectl port-forward service/pulsar-mini-grafana --address 0.0.0.0 -n pulsar $PLSR_GRFN_SVC_XTFWPORT:$PLSR_GRFN_SVC_LBPORT --context kind-kind-pg-0 > /dev/null 2>&1 &

# {"u": "pulsar", "p": "pulsar"}

# Stop Port-Forwarding for Pulsar Runtime Grafana
ps aux | grep -i kubectl | grep -v grep | grep -e "port-forward service/pulsar-mini-grafana --address 0.0.0.0 -n pulsar $PLSR_GRFN_SVC_XTFWPORT:$PLSR_GRFN_SVC_LBPORT --context kind-kind-pg-0" | awk {'print $2'} | xargs kill
```


## *Off-Cluster* `Prometheus`+`Alert Manager` Setup & Configuration

## *Off-Cluster* `Grafana` Setup & Configuration

## *Off-Cluster* `Incident Management #Board` Setup & Configuration

## Setup `Static File Server` on the build host to stage NiFi Archives to be used in `Pulsar Runtime`
```bash
docker pull halverneus/static-file-server:v1.8.6
mkdir -p /home/admin/shared/DockerVolumes/SFS-0
docker run -d \
    --name sfs-0 \
    -v /home/admin/shared/DockerVolumes/SFS-0:/web \
    -p 18881:8080 \
    halverneus/static-file-server:v1.8.6
```

## Teardown
```bash
# Clean-up
kind delete cluster --name kind-pg-0
```
