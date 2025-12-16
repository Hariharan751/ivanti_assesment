# DevOps Senior Engineer Technical Assessment

## Overview

This repository contains a comprehensive, production-ready code example demonstrating core DevOps capabilities for the Ivanti DevOps Senior Engineer technical assessment. The implementation showcases infrastructure automation, Kubernetes orchestration, CI/CD pipeline design, and multi-environment management with emphasis on scalability, reliability, security, and operational excellence.

**Note:** This is a code-only demonstration designed for assessment purposes. Infrastructure is not actively deployed to minimize cloud costs while maintaining full reproducibility.

---

## Architecture

```
GitHub Repository
    |
    v
Jenkins CI/CD Pipeline
    |
    ├── Stage 1: Build Docker Image
    ├── Stage 2: Push to ECR
    ├── Stage 3: Deploy to Kubernetes
    |
    v
Amazon EKS Cluster (Multi-Environment)
    |
    ├── Rolling Deployments
    ├── Auto-scaling (HPA)
    └── Load Balancing
```

---

## Repository Structure

```
.
├── terraform/
│   ├── modules/
│   │   ├── vpc/                 # VPC networking configuration
│   │   └── eks/                 # EKS cluster provisioning
│   └── envs/
│       ├── dev/                 # Development environment
│       ├── preprod/             # Pre-production environment
│       └── prod/                # Production environment
├── k8s/
│   ├── deployment.yaml          # Application deployment manifest
│   ├── service.yaml             # Kubernetes service configuration
│   └── hpa.yaml                 # Horizontal Pod Autoscaler
├── Jenkinsfile                  # CI/CD pipeline definition
└── README.md
```

---

## Infrastructure as Code (Terraform)

### Design Principles

- **Modularity:** Terraform modules enforce consistency and enable code reuse
- **Multi-Environment Isolation:** Separate configurations for dev, preprod, and prod ensure environment-specific control
- **Scalability:** Environment parameters (node count, instance types) are configurable independently
- **State Management:** Each environment maintains its own Terraform state for isolation and safety

### Core Components

- **VPC:** Public and private subnet configuration across multiple availability zones
- **Amazon EKS:** Managed Kubernetes cluster with version management capabilities
- **Managed Node Groups:** Auto-scaling node pools with configurable instance types
- **IAM & IRSA:** Service-level authentication enabling secure pod-to-AWS service communication

### Execution

The following commands validate and plan the infrastructure without applying changes:

```bash
terraform init      # Initialize Terraform working directory
terraform validate  # Validate configuration syntax
terraform plan      # Preview infrastructure changes
```

---

## Kubernetes Configuration

### Workload Management

**Deployment**
- Multi-replica configuration for high availability
- Rolling update strategy ensures zero-downtime deployments
- Liveness and readiness probes enable self-healing

**Service**
- LoadBalancer type provides external access
- Service discovery within cluster via DNS

**Auto-Scaling**
- Horizontal Pod Autoscaler (HPA) scales replicas based on CPU utilization
- Automatic scale-down during low-demand periods

### Failure Handling & Resilience

- Kubernetes automatically restarts failed containers
- Pod disruption budgets maintain availability during voluntary disruptions
- HPA scales capacity during traffic spikes
- Rolling updates prevent downtime during deployments

---

## CI/CD Pipeline (Jenkins)

### Pipeline Stages

1. **Source Checkout:** Clone application repository from GitHub
2. **Build:** Construct Docker image with application code and dependencies
3. **Registry Push:** Push image to AWS ECR with semantic versioning
4. **Deploy:** Apply Kubernetes manifests to target cluster via kubectl

### Security Model

- **IAM Authentication:** Jenkins uses IAM roles for AWS access (no static credentials)
- **Secrets Management:** Sensitive data is managed via Kubernetes Secrets or AWS Secrets Manager
- **Image Scanning:** ECR can be configured for container vulnerability scanning
- **Audit Logging:** All pipeline activities are logged for compliance and troubleshooting

---

## Multi-Environment Strategy

| Environment | Purpose | Characteristics |
|---|---|---|
| **dev** | Development & feature testing | Single-node cluster, minimal resources, rapid iteration |
| **preprod** | Production-like validation | Multi-node cluster, production configuration, integration testing |
| **prod** | Live production workloads | Multi-AZ deployment, enhanced monitoring, strict change control |

### Environment Isolation

Each environment includes:
- Independent Terraform state (prevents cross-environment contamination)
- Separate Kubernetes clusters (dedicated resources and security boundaries)
- Environment-specific scaling policies (dev: minimal; prod: maximum availability)
- Independent upgrade and maintenance schedules

---

## Change Management

### Application Updates

- **Rolling Deployments:** Gradual replica replacement ensures zero downtime
- **Image Versioning:** Container images tagged with Git commit SHA enable rapid rollback
- **Deployment Validation:** Readiness probes verify successful container startup before traffic routing

### Infrastructure Updates

- **Controlled Rollout:** Terraform enables staged updates across environments
- **EKS Version Management:** Cluster upgrades performed per-environment with validation steps
- **Node Group Scaling:** Horizontal and vertical scaling handled independently by environment

---

## Networking & Security

### Network Architecture

- **Private Subnets:** Worker nodes run in private subnets with controlled egress
- **Public Access:** LoadBalancer and Ingress provide controlled external entry points
- **Network Policies:** Kubernetes network policies restrict inter-pod communication (optional enhancement)

### Security Controls

- **IAM Roles for Service Accounts (IRSA):** Pod-level AWS authentication eliminates credential sharing
- **Least-Privilege IAM:** Service accounts have minimal required permissions
- **Secrets Management:** No sensitive data in source control; use external secret managers
- **Image Registry:** ECR with private access and image scanning

---

## Future Enhancements

Given additional development time, the following additions would strengthen the solution:

- **Remote State Management:** S3 backend with DynamoDB locking for team collaboration
- **Ingress Controller:** AWS ALB Ingress Controller for advanced routing and TLS termination
- **GitOps Workflow:** ArgoCD or Flux for declarative, Git-driven deployments
- **Observability Stack:** Prometheus for metrics, Grafana for visualization, ELK for logging
- **Policy Enforcement:** OPA/Kyverno for workload compliance and security policies
- **Disaster Recovery:** Automated backup and restoration procedures
- **Load Testing:** Synthetic monitoring and capacity planning validation

---

## Implementation Notes

This project was intentionally designed as a code-only demonstration to prioritize:

- **Design Quality:** Clear architectural decisions and rationale
- **Best Practices:** Industry-standard patterns for production workloads
- **Reproducibility:** Complete documentation enabling re-implementation
- **Cost Efficiency:** No active cloud resources; configuration can be activated with credentials
- **Assess Thinking:** Emphasis on *how* and *why* over operational overhead

The implementation mirrors real-world production workflows and maintains operational readiness for immediate activation.

---

## Validation Checklist

- ✅ Infrastructure as Code (Terraform) with modular design
- ✅ Kubernetes cluster provisioning and management (Amazon EKS)
- ✅ CI/CD automation (Jenkins pipeline)
- ✅ Multi-environment support (dev, preprod, prod)
- ✅ Scalability (HPA, auto-scaling node groups)
- ✅ Failure handling (pod restart, readiness probes)
- ✅ Security (IAM, IRSA, secrets management)
- ✅ Zero-downtime deployments (rolling updates)
- ✅ Infrastructure updates (Terraform-driven)

---

## Getting Started (Local Validation)

### Prerequisites

- Terraform >= 1.0
- kubectl >= 1.24
- AWS credentials (with appropriate permissions)
- Git

### Validation Commands

```bash
# Validate Terraform configuration
cd terraform/envs/dev
terraform init
terraform validate
terraform plan

# Validate Kubernetes manifests
kubectl apply -f k8s/ --dry-run=client
```

---

## Conclusion

This technical assessment demonstrates a production-oriented DevOps approach grounded in:

- **Automation:** Infrastructure as code eliminates manual operations
- **Scalability:** Multi-environment architecture supports growth and diversity
- **Reliability:** Kubernetes patterns ensure application resilience
- **Security:** Zero-trust principles and least-privilege access controls
- **Maintainability:** Modular design and comprehensive documentation enable team collaboration
