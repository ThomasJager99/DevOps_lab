#!/bin/bash

CONFIG="/path/to/xray/config.json"
IP="SERVER_IP"
PBK="PUBLIC_KEY"
SID="SHORT_ID"
SNI="SNI_HOST"

read -p "Enter username: " USERNAME

if [ -z "$USERNAME" ]; then
  echo "ERROR: username is empty"
  exit 1
fi

UUID=$(xray uuid)

echo "New UUID: $UUID"

# Validate JSON
jq . "$CONFIG" > /dev/null 2>&1 || {
  echo "ERROR: config.json is invalid"
  exit 1
}

# Add user with email field
jq '.inbounds[0].settings.clients += [{
  "id":"'"$UUID"'",
  "flow":"xtls-rprx-vision",
  "email":"'"$USERNAME"'"
}]' "$CONFIG" > /tmp/xray.json && mv /tmp/xray.json "$CONFIG"

# Restart service
systemctl restart xray

systemctl is-active --quiet xray || {
  echo "ERROR: Xray failed to start"
  exit 1
}

# Generate connection link
LINK="vless://$UUID@$IP:443?encryption=none&security=reality&sni=$SNI&fp=chrome&pbk=$PBK&sid=$SID&type=tcp&flow=xtls-rprx-vision#$USERNAME"

echo
echo "USER: $USERNAME"
echo "UUID: $UUID"

echo
echo "LINK:"
echo "$LINK"

echo
echo "QR:"
qrencode -t ansiutf8 "$LINK"
