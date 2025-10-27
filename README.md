# Cloud-Native Lab

This repository contains the Infrastructure-as-Code and GitOps configuration for **Cloud-Native Lab**, built to simulate an enterprise-scale Kubernetes environment on a single Proxmox host.

## Overview

- Proxmox virtualization (pfSense, Bastion, K3s Cluster)
- IaC with Terraform + Ansible
- GitOps with ArgoCD
- Observability: Prometheus, Grafana, Loki
- CI/CD: AWX
- Secure network: pfSense + VPN

## Structure
| Directory | Description |
|------------|-------------|
| terraform/ | VM provisioning on Proxmox |
| ansible/ | Node configuration and K3s install |
| kubernetes/ | GitOps-managed apps and manifests |
| docs/ | Architecture and documentation |


