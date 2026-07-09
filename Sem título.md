#!/usr/bin/env bash

# Manual "pica o ponto" helper for app.cstaff.eu — run by hand, never automated.

set -euo pipefail

API_BASE="${CSTAFF_API_BASE:-https://app.cstaff.eu/api}"

ACTION="${1:-check-in}"

KIND="${2:-pausa}"

case "$ACTION" in

  check-in|check-out|lunch-out|lunch-in) ;;

  *)

    echo "Uso: $(basename "$0") [check-in|check-out|lunch-out|lunch-in] [pausa|almoco]" >&2

    exit 1

    ;;

esac

if [ "$ACTION" = "lunch-out" ]; then

  case "$KIND" in

    pausa|almoco) ;;

    *)

      echo "Kind inválido: '$KIND' (usa 'pausa' ou 'almoco')" >&2

      exit 1

      ;;

  esac

fi

read -rp "Utilizador: " CSTAFF_USERNAME

read -rsp "Password: " CSTAFF_PASSWORD

echo

read default_lat default_lon < <(

awk 'BEGIN{

    srand()

    lat = 38.7581551 + rand() * (38.7582449 - 38.7581551)

    lon = -9.3825476 + rand() * (-9.3824324 - (-9.3825476))

    printf "%.7f %.7f\n", lat, lon

}'

)

default_lat="${CSTAFF_LAT:-$default_lat}"

default_lon="${CSTAFF_LON:-$defaul

default_acc="${CSTAFF_ACCURACY:-10}"

read -rp "Latitude [${default_lat}]: " lat

lat="${lat:-$default_lat}"

read -rp "Longitude [${default_lon}]: " lon

lon="${lon:-$default_lon}"

read -rp "Precisão GPS em metros [${default_acc}]: " accuracy

accuracy="${accuracy:-$default_acc}"

login_response=$(curl -sS -X POST "$API_BASE/auth/login" \

  -H "Content-Type: application/json" \

  -d "$(python3 -c 'import json,sys; print(json.dumps({"username": sys.argv[1], "password": sys.argv[2]}))' "$CSTAFF_USERNAME" "$CSTAFF_PASSWORD")")

unset CSTAFF_PASSWORD

access_token=$(python3 -c 'import json,sys; print(json.load(sys.stdin).get("accessToken",""))' <<<"$login_response")

if [ -z "$access_token" ]; then

  echo "Login falhou:" >&2

  echo "$login_response" >&2

  exit 1

fi

notes=""

if [ "$ACTION" = "lunch-out" ]; then

  notes="$KIND"

fi

payload=$(python3 -c '

import json, sys

lat, lon, acc, notes = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]

body = {}

if lat:

    body["latitude"] = float(lat)

if lon:

    body["longitude"] = float(lon)

if acc:

    body["gpsAccuracy"] = float(acc)

if notes:

    body["notes"] = notes

print(json.dumps(body))

' "$lat" "$lon" "$accuracy" "$notes")

response=$(curl -sS -X POST "$API_BASE/hrm/attendance/user/$ACTION" \

  -H "Content-Type: application/json" \

  -H "Authorization: Bearer $access_token" \

  -d "$payload")

echo "$response" | python3 -m json.tool 2>/dev/null || echo "$response"