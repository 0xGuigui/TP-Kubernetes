# TP-Kubernetes---Minecraft
TP réalisé par Doriane pour Guilhem dans le but d'apprendre Kubernetes ainsi que les composants qui l'entourent

---

# Notes:

- PC Taff, K3D -> Script sera donné pour initialisé le cluster avec un serveur Minecraft
- PC Perso, Minikube -> Script sera donné pour initialisé le cluster avec un serveur Minecraft



---
# HELM

```bash
$ helm version
```
On vérifie que `helm` est installé sur la machine. Si ça répond avec une version, c'est ok, autrement, il faut l’installer avec la commande:

Linux:
```bash
$ curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

Mac:
On install Brew:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
````

On installe helm

```bash
brew install helm
```

---

Windows (via Chocolatey) :  
Installez Chocolatey si besoin :
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol = `
[System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

Puis on installe Helm :
```powershell
choco install kubernetes-helm
```

---

## Création du secret pour le serveur MC

Le serveur Minecraft a besoin de certains paramètres sensibles spéciaux, notamment accepter l’EULA, whitelist, blacklist. Pour ce faire, on utilise un `Secret` Kubernetes pour stocker ça.

On s'assure d’avoir les fichiers `whitelist.json` et `blacklist.json` dans la racine du repo. /#TODO à modifier, trop crado/

```bash
$ kubectl create secret generic minecraft-secrets \
  --from-literal=eula=true \
  --from-file=whitelist.json=./whitelist.json \
  --from-file=blacklist.json=./blacklist.json
```

Si le secret existe déjà et qu'on doit le recréer :
```bash
$ kubectl delete secret minecraft-secrets
```
Puis on relance avec la commande `create secret`