# Setup Kind
- `Windows 10` - `Power Shell/.ps1`
## Preparation
```ps1
mkdir D:\App\cicd\challenges\KinD\deploy\xperiment\kind-k8s\ps\config
mkdir D:\App\cicd\challenges\KinD\deploy\xperiment\kind-k8s\ps\platform-test-app
# Write KinD config .yaml
echo @'
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
'@ > D:\App\cicd\challenges\KinD\deploy\xperiment\kind-k8s\ps\config\kind-config.yaml

# Validate - KinD config .yaml
Get-Content -Path D:\App\cicd\challenges\KinD\deploy\xperiment\kind-k8s\ps\config\kind-config.yaml

# Retrieve MetalLB K8s Resources manifest .yaml
curl.exe -Lo D:\App\cicd\challenges\KinD\deploy\xperiment\kind-k8s\ps\config\metallb.yaml https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/metallb.yaml

# Write MetalLB configmap .yaml
echo @'
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: metallb-pool-config
data:
  config: |
    address-pools:
    - name: docker-ce-nonix-local
      protocol: layer2
      addresses:
      - 127.0.0.220-127.0.0.250
'@ > D:\App\cicd\challenges\KinD\deploy\xperiment\kind-k8s\ps\config\kind-metallb-configmap.yaml

# Write Node Metric Exporter config .yaml
echo @'
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
'@ > D:\App\cicd\challenges\KinD\deploy\xperiment\kind-k8s\ps\config\ndxptr-dset-config.yaml

# Validate - Node Metric Exporter config .yaml


# Write - MetalLB Basic Integration Test Service
echo @'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
spec:
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1
        ports:
        - name: http
          containerPort: 80
'@ > D:\App\cicd\challenges\KinD\deploy\xperiment\kind-k8s\ps\platform-test-app\metallb-dryrun-nginx-app-deploy.yaml

echo @'
apiVersion: v1
kind: Service
metadata:
  name: nginx
spec:
  ports:
  - name: http
    port: 48080
    protocol: TCP
    targetPort: 80
  selector:
    app: nginx
  type: LoadBalancer
'@ > D:\App\cicd\challenges\KinD\deploy\xperiment\kind-k8s\ps\platform-test-app\metallb-dryrun-nginx-app-svc.yaml
```

## Setup KinD Cluster
```ps1
mkdir D:\Kind\v0.12.0\bin
cd D:\Kind\v0.12.0\bin
curl.exe -Lo kind-windows-amd64.exe https://kind.sigs.k8s.io/dl/v0.12.0/kind-windows-amd64
Move-Item .\kind-windows-amd64.exe D:\Kind\v0.12.0\bin\kind.exe
$Env:KIND_H="D:\Kind\v0.12.0"
$Env:Path=$Env:KIND_H+'\bin'+';'+$Env:Path

kind create cluster --name kind-pg-0 --config D:\App\cicd\challenges\KinD\deploy\xperiment\kind-k8s\ps\config\kind-config.yaml

kubectl cluster-info --context kind-kind-pg-0

# Apply MetalLB Manifest
kubectl create ns metallb-system --context kind-kind-pg-0
kubectl apply --context kind-kind-pg-0 -f D:\App\cicd\challenges\KinD\deploy\xperiment\kind-k8s\ps\config\metallb.yaml
# * Clean-up
# ** kubectl delete --context kind-kind-pg-0 -f D:\App\cicd\challenges\KinD\deploy\xperiment\kind-k8s\ps\config\metallb.yaml
kubectl get pods -n metallb-system --context kind-kind-pg-0 --watch

# Apply MetalLB ConfigMap
kubectl apply --context kind-kind-pg-0 -f D:\App\cicd\challenges\KinD\deploy\xperiment\kind-k8s\ps\config\kind-metallb-configmap.yaml
# Test
kubectl apply --context kind-kind-pg-0 -f D:\App\cicd\challenges\KinD\deploy\xperiment\kind-k8s\ps\platform-test-app\metallb-dryrun-nginx-app-deploy.yaml
kubectl apply --context kind-kind-pg-0 -f D:\App\cicd\challenges\KinD\deploy\xperiment\kind-k8s\ps\platform-test-app\metallb-dryrun-nginx-app-svc.yaml

kubectl get deploy --all-namespaces --context kind-kind-pg-0
kubectl get service --all-namespaces --context kind-kind-pg-0

# * Clean-up
# ** kind delete cluster --name kind-pg-0

```
