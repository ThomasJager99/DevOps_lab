Вот такой же чистый Markdown для Xray, без лишнего, но с нормальным конфигом (Reality + ключи + shortId).

# Xray Setup (VLESS + Reality)

## Install

```bash
bash <(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)

Enable IPv4 Forwarding

echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

Disable IPv6

echo "net.ipv6.conf.all.disable_ipv6=1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6=1" >> /etc/sysctl.conf
sysctl -p

NAT (Masquerade)

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
netfilter-persistent save

Generate UUID

cat /proc/sys/kernel/random/uuid

Generate Reality Keys

xray x25519

Output:

Private key: ...
Public key(Password - in new version): ...
Harsh32: ...

Generate Short ID

openssl rand -hex 8

Configuration

nano /usr/local/etc/xray/config.json

{
  "log": {
    "loglevel": "warning"
  },

  "inbounds": [
    {
      "port": 443,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "UUID_HERE",
            "flow": "xtls-rprx-vision"
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "tcp",
        "security": "reality",
        "realitySettings": {
          "show": false,
          "dest": "www.cloudflare.com:443",
          "xver": 0,
          "serverNames": [
            "www.cloudflare.com",
            "www.google.com"
          ],
          "privateKey": "PRIVATE_KEY_HERE",
          "shortIds": [
            "SHORT_ID_HERE"
          ]
        }
      }
    }
  ],

  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}

Start Service

systemctl enable xray
systemctl start xray

Check Status

systemctl status xray

Test

Check that port is open:

ss -tulnp | grep 443
