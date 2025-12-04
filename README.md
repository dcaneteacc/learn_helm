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

