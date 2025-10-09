## ☸️ kubernetes

Complete prometheus monitoring stack setup on Kubernetes.

Idea of this repo to understand all the components involved in prometheus setup.

You can find the full tutorial from here--> [Kubernetes Monitoting setup Using Prometheus](https://devopscube.com/setup-prometheus-monitoring-on-kubernetes/)

## 🚀 CKA, CKAD, CKS, KCNA & PCA Coupon Codes

If you are preparing for CKA, CKAD, CKS, or KCNA exam, **save 20%** today using code **SCRIPT20** at https://kube.promo/devops. It is a limited-time offer. 

## Other Manifest repos

Kube State metrics manifests: https://github.com/devopscube/kube-state-metrics-configs

Alert manager Manifests: https://github.com/bibinwilson/kubernetes-alert-manager

Grafana manifests: https://github.com/bibinwilson/kubernetes-grafana

Node Exporter manifests: https://github.com/bibinwilson/kubernetes-node-exporter

```
kubectl --namespace monitoring port-forward $POD_NAME 9091
kubectl port-forward -n monitoring svc/prometheus-server 9090:80
microk8s kubectl rollout restart deployment kiali -n istio-system
microk8s kubectl delete deployment,svc,sa,role,rolebinding,configmap -l app=kiali -n istio-system


microk8s helm3 upgrade kiali-server kiali/kiali-server -n istio-system \
  --set external_services.prometheus.url=http://prometheus-server.istio-system.svc.cluster.local
```


