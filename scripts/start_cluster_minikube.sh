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
echo "Initialisation du cluster Minecraft avec Minikube..."
echo ""

if ! command -v minikube &> /dev/null; then
    echo "Minikube n'est pas installé sur votre système."
    echo "Vérification si K3d est disponible..."
    if command -v k3d &> /dev/null; then
        echo "K3d est installé. Voulez-vous utiliser K3d pour démarrer le cluster ? (y/n)"
        read -r response
        if [[ "$response" == "y" || "$response" == "Y" ]]; then
            echo "Exécution du script 'start_cluster_k3d.sh'..."
            ./start_cluster_k3d.sh
            exit 0
        else
            echo "Aucun gestionnaire de cluster disponible. Veuillez installer Minikube ou K3d."
            exit 1
        fi
    else
        echo "Ni Minikube ni K3d ne sont installés. Veuillez installer l'un des deux pour continuer."
        exit 1
    fi
fi

if minikube profile list | grep -q minecraft-cluster; then
    echo "Le cluster 'minecraft-cluster' existe déjà. Voulez-vous le supprimer et le recréer ? (y/n)"
    read -r response
    if [[ "$response" == "y" || "$response" == "Y" ]]; then
        echo "Suppression du cluster existant..."
        minikube delete --profile=minecraft-cluster
    else
        echo "Utilisation du cluster existant 'minecraft-cluster'."
        exit 0
    fi
fi

minikube start --driver=docker --profile=minecraft-cluster
echo ""
echo "Cluster Minikube 'minecraft-cluster' démarré avec succès !"
echo "Accédez au cluster avec 'kubectl --context=minecraft-cluster'."
echo ""
echo "Ouverture du dashboard Minikube..."
minikube dashboard --profile=minecraft-cluster