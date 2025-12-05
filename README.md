# Learn Helm

This is a project to learn Helm + Argo CD

# Architecture

                      ┌──────────────────────────┐
                      │        Mac Local         │
                      │                          │
                      │   ┌──────────────────┐   │
                      │   │ GitHub (Repo)    │◄───────────────┐
                      │   │ Helm chart       │                │
                      │   └──────────────────┘                │
                      │            ▲ push                     │
                      │            │                          │
                      │   ┌──────────────────┐   pull/monitor │
                      │   │    Argo CD       │────────────────┘
                      │   │ (GitOps engine)  │
                      │   └──────────────────┘
                      │            │ deploy
                      │            │
                      │   ┌──────────────────┐
                      │   │   Minikube       │
                      │   │ (Kubernetes)     │
                      │   └──────────────────┘
                      │            │
                      │   ┌──────────────────┐
                      │   │ App Helm (Pods)  │
                      │   │  Services/Ingress│
                      │   └──────────────────┘
                      │
                      └──────────────────────────┘

# Instalation
```
# Install docker
brew install --cask docker

# Install minikube
brew install minikube
minikube start

# Check minikube nodes
kubectl get nodes

# Open minikube dashboard
minikube dashboard

# Install Argo C into minikube
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Check and wait for pods deploy
kubectl get pods -n argocd

# Install helm
brew install helm

# Check Helm
helm version
```

# Open Argo CD
```
# Expose Argo C app on 8080
kubectl port-forward svc/argocd-server -n argocd 8080:443

# Create a credentials to use Argo CD with 'admin' user
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d
```

# Create Helm demo-app

Example to install a demo app.

```
helm create demo-app

helm install demo-app ./demo-app

kubectl get all

kubectl port-forward svc/demo-app 8080:80

helm upgrade demo-app ./demo-app

helm uninstall demo-app
```

# Create and Deploy a Hello HTML 

Example using external chart from bitnami repo

```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm create hello-nginx
cd hello-nginx

kubectl apply -f configmap.yaml
helm install hello-nginx bitnami/nginx -f values.yaml

kubectl logs deployment/hello-nginx

kubectl port-forward svc/hello-nginx 8080:80

kubectl get pods
kubectl exec -it hello-nginx-XXXXXXXX -- sh

helm upgrade --install hello-nginx bitnami/nginx
```
