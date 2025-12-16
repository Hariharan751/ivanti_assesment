DevOps Senior Engineer Technical Assessment
Overview

This repository contains a code-only working example demonstrating core DevOps capabilities requested in the Ivanti DevOps Senior Engineer technical assessment:

Infrastructure as Code using Terraform

Kubernetes cluster provisioning and management (Amazon EKS)

CI/CD pipeline design using Jenkins

Support for multiple environments (dev / preprod / prod)

Consideration of scalability, failure handling, security, and upgrades

The focus of this project is on infrastructure design, automation, and operational thinking, not on application complexity.

Architecture
GitHub Repository
        |
        v
Jenkins Pipeline
        |
        |-- Build Docker Image
        |-- Push to Container Registry (ECR)
        |-- Deploy Kubernetes Manifests
        v
Amazon EKS Cluster
        |
        |-- Deployment (Rolling Updates)
        |-- Service (LoadBalancer)
        |-- HPA (Auto Scaling)

Repository Structure
.
├── terraform/
│   ├── modules/
│   │   ├── vpc/
│   │   └── eks/
│   └── envs/
│       ├── dev/
│       ├── preprod/
│       └── prod/
├── k8s/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── hpa.yaml
├── Jenkinsfile
└── README.md

Infrastructure as Code (Terraform)
Design

Terraform modules are used to enforce consistency and reuse

Separate environments (dev, preprod, prod) ensure isolation

Environment-specific sizing (node count, instance types) can be adjusted independently

Components

VPC with public and private subnets

Amazon EKS cluster

Managed node groups

IAM and IRSA enabled for secure pod-level access

Execution

For this assessment, infrastructure is not applied to avoid cloud costs.
The following commands validate the setup:

terraform init
terraform validate
terraform plan

Kubernetes
Workloads

Deployment

Multiple replicas

Rolling update strategy for zero downtime

Liveness & readiness probes

Service

LoadBalancer for external access

Horizontal Pod Autoscaler

CPU-based auto-scaling

Failure & Load Handling

Kubernetes automatically restarts failed pods

HPA scales the application during traffic spikes

Rolling updates prevent downtime during deployments

CI/CD Pipeline (Jenkins)
Pipeline Stages

Source checkout

Docker image build

Image push to container registry (ECR)

Kubernetes deployment using kubectl

Security

Jenkins authenticates to AWS using IAM roles

No static credentials stored in code

Secrets would be managed using Kubernetes Secrets or AWS Secrets Manager

Multi-Environment Strategy
Environment	Purpose
dev	Development & testing
preprod	Production-like validation
prod	Live production workloads

Each environment has:

Independent Terraform state

Separate Kubernetes clusters

Independent scaling and upgrade strategies

Infrastructure & Application Changes
Application Changes

Rolling deployments ensure zero downtime

Versioned container images allow easy rollback

Infrastructure Changes

Terraform enables controlled upgrades

EKS version upgrades can be performed per environment

Node group scaling handled independently

Networking & Security Considerations

Private subnets for worker nodes

Public access via LoadBalancer / Ingress

IAM Roles for Service Accounts (IRSA)

Least-privilege IAM policies

No sensitive data committed to source control

Future Improvements

Given additional time, the following enhancements would be added:

Remote Terraform state with S3 + DynamoDB locking

Ingress controller with AWS ALB

GitOps deployment model

Monitoring and alerting (Prometheus, Grafana)

Policy enforcement (OPA / Kyverno)

Notes

This project was intentionally implemented as a code-only example to focus on:

Design decisions

Best practices

Reproducibility

Cost-safe assessment execution

The implementation mirrors real-world production workflows and can be activated by adding cloud credentials and pipeline integrations.

Conclusion

This repository demonstrates a production-oriented DevOps approach, focusing on:

Automation

Scalability

Reliability

Security

Maintainability