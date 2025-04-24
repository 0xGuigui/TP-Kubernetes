#!/bin/bash

set -e

echo "======================================================"
echo "  __  __ _             _____ _           _            "
echo " |  \/  (_)           / ____| |         | |           "
echo " | \  / |_ _ __   ___| |    | |_   _ ___| |_ ___ _ __ "
echo " | |\/| | | '_ \ / _ \ |    | | | | / __| __/ _ \ '__|"
echo " | |  | | | | | |  __/ |____| | |_| \__ \ ||  __/ |   "
echo " |_|  |_|_|_| |_|\___|\_____|_|\__,_|___/\__\___|_|   "
echo "                                                      "
echo "======================================================"
echo "Initialisation du cluster Minecraft avec K3d..."
echo ""

if ! command -v k3d &> /dev/null; then
    echo "K3d n'est pas installé sur votre système."
    echo "Vérification si Minikube est disponible..."
    if command -v minikube &> /dev/null; then
        echo "Minikube est installé. Voulez-vous utiliser Minikube pour démarrer le cluster ? (y/n)"
        read -r response
        if [[ "$response" == "y" || "$response" == "Y" ]]; then
            echo "Exécution du script 'start_cluster_minikube.sh'..."
            ./start_cluster_minikube.sh
            exit 0
        else
            echo "Aucun gestionnaire de cluster disponible. Veuillez installer K3d ou Minikube."
            exit 1
        fi
    else
        echo "Ni K3d ni Minikube ne sont installés. Veuillez installer l'un des deux pour continuer."
        exit 1
    fi
fi
if k3d cluster list | grep -q minecraft-cluster; then
    echo "Le cluster 'minecraft-cluster' existe déjà. Voulez-vous le supprimer et le recréer ? (y/n)"
    read -r response
    if [[ "$response" == "y" || "$response" == "Y" ]]; then
        echo "Suppression du cluster existant..."
        k3d cluster delete minecraft-cluster
    else
        echo "Utilisation du cluster existant 'minecraft-cluster'."
        exit 0
    fi
fi
k3d cluster create minecraft-cluster --agents 2
echo ""
echo "Cluster K3d 'minecraft-cluster' démarré avec succès !"
echo "Accédez au cluster avec 'kubectl get nodes'."
if command -v k3d-ui &> /dev/null; then
    echo ""
    echo "Ouverture de k3d-ui..."
    k3d-ui
else
    echo "k3d-ui n'est pas installé. Vous pouvez l'installer pour une interface graphique."
fi