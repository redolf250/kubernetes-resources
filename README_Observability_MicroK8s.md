# 📊 Observability Setup in MicroK8s with Istio, Prometheus, and Kiali

This guide explains how to install and configure **Prometheus** and **Kiali** for observability in a **MicroK8s** cluster with **Istio**.

---

## 🧩 Prerequisites

Ensure you have the following:
- MicroK8s installed and running.
- Istio enabled in MicroK8s.
- Helm 3 available (MicroK8s provides `microk8s helm3`).

Check status:
```bash
microk8s status --wait-ready
```

Enable Istio if not done yet:
```bash
microk8s enable istio
```

---

## 📦 Step 1: Create Namespace

```bash
microk8s kubectl create namespace istio-system --dry-run=client -o yaml | microk8s kubectl apply -f -
```

---

## 📈 Step 2: Install Prometheus with Helm

Add the Helm repo and update:
```bash
microk8s helm3 repo add prometheus-community https://prometheus-community.github.io/helm-charts
microk8s helm3 repo update
```

Install Prometheus:
```bash
microk8s helm3 install prometheus prometheus-community/prometheus -n istio-system
```

Check the pods:
```bash
microk8s kubectl get pods -n istio-system | grep prometheus
```

Expected output:
```
prometheus-alertmanager-0
prometheus-kube-state-metrics-*
prometheus-prometheus-node-exporter-*
prometheus-prometheus-pushgateway-*
prometheus-server-*
```

### 🛰️ Access Prometheus
Forward the port to access Prometheus locally:
```bash
microk8s kubectl port-forward -n istio-system svc/prometheus-server 9090:80
```
Then open: [http://localhost:9090](http://localhost:9090)

---

## 🧭 Step 3: Install Kiali with Helm

Add the Kiali Helm repo:
```bash
microk8s helm3 repo add kiali https://kiali.org/helm-charts
microk8s helm3 repo update
```

Install Kiali:
```bash
microk8s helm3 install kiali-server kiali/kiali-server -n istio-system
```

If you previously installed Kiali manually and get an error like:
```
Error: INSTALLATION FAILED: ClusterRole "kiali-viewer" ... exists and cannot be imported
```
then delete the old roles and try again:
```bash
microk8s kubectl delete clusterrole kiali-viewer kiali -n istio-system --ignore-not-found
microk8s kubectl delete clusterrolebinding kiali-viewer kiali -n istio-system --ignore-not-found
```

Then reinstall with Helm.

Check pods:
```bash
microk8s kubectl get pods -n istio-system | grep kiali
```

Expected output:
```
kiali-xxxxxxx-yyyyy   1/1     Running   0   Xs
```

---

## 🌐 Step 4: Access Kiali Dashboard

Port-forward Kiali service:
```bash
microk8s kubectl port-forward -n istio-system svc/kiali 20001:20001
```

Then visit: [http://localhost:20001](http://localhost:20001)

Login credentials are auto-generated; you can find them with:
```bash
microk8s kubectl get secret -n istio-system kiali -o jsonpath="{.data.username}" | base64 --decode
microk8s kubectl get secret -n istio-system kiali -o jsonpath="{.data.passphrase}" | base64 --decode
```

---

## 🔍 Step 5: Verify Integration

Ensure Istio metrics are visible in Prometheus and Kiali shows service graph data.

If you added external services (e.g., via a `ServiceEntry`), ensure Prometheus can scrape metrics and Kiali can visualize traffic.

---

## ✅ Troubleshooting

### Prometheus not accessible
Make sure the service is reachable:
```bash
microk8s kubectl get svc -n istio-system | grep prometheus
```

### Kiali login fails
Reset Kiali credentials:
```bash
microk8s kubectl delete secret -n istio-system kiali
microk8s helm3 upgrade --install kiali-server kiali/kiali-server -n istio-system
```

---

## 🧠 Summary

| Component | Installed via | Namespace | Port | Access URL |
|------------|----------------|------------|------|-------------|
| Istio | `microk8s enable istio` | `istio-system` | 15021 | N/A |
| Prometheus | `helm3 install prometheus` | `istio-system` | 9090 | [http://localhost:9090](http://localhost:9090) |
| Kiali | `helm3 install kiali-server` | `istio-system` | 20001 | [http://localhost:20001](http://localhost:20001) |

---

**Author:** DevOps Setup (MicroK8s + Istio + Observability)  
**Date:** October 2025
