#!/usr/bin/env bash
# ==============================================================================
# deploy.sh - Despliegue de menu-service en Azure Container Apps
# ==============================================================================
set -euo pipefail

NOMBRE="${NOMBRE:-oscarlasso}"
RG="${RG:-rg-arepas-$NOMBRE}"
LOC="${LOC:-northcentralus}"
APP_NAME="menu-service"

echo "==> Desplegando $APP_NAME en Azure Container Apps ($RG / arepas-env)..."

# Empaquetar proyecto Maven si existe pom.xml
if [ -f "pom.xml" ]; then
  mvn -q package -DskipTests
fi

az containerapp up --name "$APP_NAME" --resource-group "$RG" --location "$LOC" \
  --environment arepas-env --source . --ingress external --target-port 8080

MENU_FQDN=$(az containerapp show -n "$APP_NAME" -g "$RG" --query properties.configuration.ingress.fqdn -o tsv)
echo "==> $APP_NAME desplegado con éxito en: https://$MENU_FQDN"
echo "==> Probando endpoint GET /menu:"
curl -s -i "https://$MENU_FQDN/menu" || true
