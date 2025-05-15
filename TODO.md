# 📝 TODO - TP Kubernetes : Déploiement d’un serveur Minecraft

## Obligatoire

- [X] Initialiser le cluster Kubernetes avec Minikube ou K3d
- [X] Vérifier que `kubectl` est bien configuré et fonctionne avec le cluster
- [X] Installer Helm sur ma machine (Linux / Mac / Windows)
- [X] Créer le secret `minecraft-secrets` avec l’EULA, la whitelist et la blacklist
- [ ] Créer ou adapter un chart Helm pour le serveur Minecraft
  - [ ] Configurer la mémoire, CPU, whitelist/blacklist, EULA dans `values.yaml`
  - [ ] Ajouter les probes `livenessProbe` et `readinessProbe` (TCP port 25565)
- [ ] Déployer le serveur Minecraft via Helm
- [ ] Vérifier le déploiement avec `kubectl get pods` et les logs
- [ ] Mettre en place la supervision avec Prometheus et Grafana
  - [ ] Ajouter un exporter compatible (ex: `mc-monitor`)
  - [ ] Créer un dashboard Grafana : CPU, RAM, joueurs connectés, latence…
- [ ] Intégrer un service mesh (Istio ou Linkerd)
  - [ ] Configurer Gateway + VirtualService pour exposer le port 25565
  - [ ] Tester un canary deployment (10% du trafic vers une nouvelle version) (ptdr)
- [ ] Mettre en place GitOps avec ArgoCD ou Flux (ptdr)
  - [ ] Synchroniser le dépôt Git avec Helm + manifests + config
- [ ] Automatiser avec un pipeline CI/CD (Jenkins ou GitLab CI)
  - [ ] Automatiser les déploiements suite à un push Git
  - [ ] Activer la mise à jour automatique via ArgoCD

---

Documenter putain...