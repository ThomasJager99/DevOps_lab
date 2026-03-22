# WireGuard Setup

## Install

```bash
apt update && apt upgrade -y
apt install -y wireguard iptables iptables-persistent

Enable IPv4 Forwarding

echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

Disable IPv6

echo "net.ipv6.conf.all.disable_ipv6=1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6=1" >> /etc/sysctl.conf
sysctl -p

Generate Keys

Server

wg genkey | tee /etc/wireguard/server_private.key | wg pubkey > /etc/wireguard/server_public.key

Client

wg genkey | tee client_private.key | wg pubkey > client_public.key

Server Configuration

nano /etc/wireguard/wg0.conf

[Interface]
PrivateKey = SERVER_PRIVATE_KEY
Address = 10.0.0.1/24
ListenPort = 51820
PostUp = iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE

[Peer]
PublicKey = CLIENT_PUBLIC_KEY
AllowedIPs = 10.0.0.2/32

Permissions

chmod 600 /etc/wireguard/wg0.conf

Start WireGuard

wg-quick up wg0

Enable on Boot

systemctl enable wg-quick@wg0

Save iptables Rules

netfilter-persistent save

Open Port

UDP 51820

Client Configuration

[Interface]
PrivateKey = CLIENT_PRIVATE_KEY
Address = 10.0.0.2/24
DNS = 1.1.1.1

[Peer]
PublicKey = SERVER_PUBLIC_KEY
Endpoint = SERVER_IP:51820
AllowedIPs = 0.0.0.0/0
PersistentKeepalive = 25

Check Status

wg

Test

curl ifconfig.me


