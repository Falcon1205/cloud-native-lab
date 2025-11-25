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

## K3s Cluster Installation via Ansible
This project provisions and configures a full K3s Kubernetes cluster using Ansible.
The cluster consists of:
1× master node
2× worker nodes
All nodes managed via passwordless SSH (SSH keys)
Automated installation using idempotent Ansible playbooks

Preparing Nodes (Updates + Swap Off):
Run from repository root or from ansible/:
ansible-playbook -i inventory/hosts.ini playbooks/prepare-k3s.yaml
What this does:
- updates APT packages
- disables swap (required for Kubernetes)
- ensures required packages are installed

Installing K3s Master Node:
ansible-playbook -i inventory/hosts.ini playbooks/install-k3s-master.yaml
This will:
- download the K3s installer
- install master node
- extract and save node-token locally into
  ansible/playbooks/k3s-node-token.txt

Installing Worker Nodes:
ansible-playbook -i inventory/hosts.ini playbooks/install-k3s-workers.yaml
Workers automatically:
- download K3s agent
- join the cluster
- register as nodes in Kubernetes

Verifying Cluster Status:
SSH to the master VM
sudo kubectl get nodes
