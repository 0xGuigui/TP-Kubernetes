#!/bin/bash

set -e

echo "======================================================"
echo "      Déploiement du serveur Minecraft via Helm        "
echo "======================================================"

if ! command -v helm &> /dev/null; then
    echo "Helm n'est pas installé. Installe-le avant de continuer."
    exit 1
fi
echo "Création du secret Minecraft EULA et whitelist..."
kubectl create secret generic minecraft-secrets \
    --from-literal=eula=true \
    --from-file=whitelist.json=../config/whitelist.json \
    --dry-run=client -o yaml | kubectl apply -f -
echo "Déploiement du chart Minecraft..."
helm upgrade --install minecraft ./helm-chart-minecraft \
    --values ./helm-chart-minecraft/values.yaml
echo ""
echo "Serveur Minecraft déployé avec succès via Helm !"
