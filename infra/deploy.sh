#!/usr/bin/env bash
set -euo pipefail

NOMBRE="${NOMBRE:-oscarlasso}"
RG="${RG:-rg-arepas-$NOMBRE}"
LOC="${LOC:-northcentralus}"
APP_NAME="menu-service"

echo "Desplegando $APP_NAME en Container Apps..."

ACR_SERVER=$(az acr list -g "$RG" --query "[0].loginServer" -o tsv)
ACR_NAME="${ACR_SERVER%%.*}"
ACR_USER=$(az acr credential show -n "$ACR_NAME" --query "username" -o tsv)
ACR_PASS=$(az acr credential show -n "$ACR_NAME" --query "passwords[0].value" -o tsv)
IMAGE="$ACR_SERVER/$APP_NAME:latest"

az containerapp up --name "$APP_NAME" --resource-group "$RG" --location "$LOC" \
  --environment arepas-env --image "$IMAGE" \
  --registry-server "$ACR_SERVER" --registry-username "$ACR_USER" --registry-password "$ACR_PASS" \
  --ingress external --target-port 8080

MENU_FQDN=$(az containerapp show -n "$APP_NAME" -g "$RG" --query properties.configuration.ingress.fqdn -o tsv)
echo "$APP_NAME desplegado en: https://$MENU_FQDN"
curl -s -i "https://$MENU_FQDN/menu" || true
