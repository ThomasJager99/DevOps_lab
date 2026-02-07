📅 **Date:** 2025-08-14
🔧 **Tools:** NetworkManager, `ip`, `dhclient`, `rfkill`, `systemctl`, `wpa_supplicant`, SSH, `ssh-keygen`

---

### How It Started

I was setting up a fresh Debian 13 system on my server and wanted to migrate from using `wpa_supplicant` manually to managing my connection with NetworkManager. Along the way, I also began syncing my workflow between my Mac and the server, using SSH.

### The Problem

* NetworkManager broke the IP settings when I tried to restart it.
* SSH wouldn’t connect after the server rebooted because IP addresses kept changing (e.g. from `.121` back to `.120`, which conflicted with saved keys on my Mac).
* Even after installing all the firmware and ensuring no blocks via `rfkill`, NetworkManager couldn’t manage the connection because `wpa_supplicant` was running independently.

### The Fix

1. **Manual IP Assignment (before DHCP setup):**

```bash
sudo ip addr add 192.189.156.120/24 dev wlp3s0
sudo ip link set wlp3s0 up
sudo ip route add default via 192.189.156.1
echo "nameserver 1.1.1.1" | sudo tee /etc/resolv.conf
```

2. **Install DHCP Client:**

```bash
sudo apt install isc-dhcp-client
sudo ip link set wlp3s0 up
sudo dhclient -r wlp3s0
sudo dhclient wlp3s0
```

3. **Check Internet:**

```bash
ip a
ping 8.8.8.8
ping google.com
```

4. **Verify Wi-Fi Module Status:**

```bash
sudo apt install rfkill
rfkill list
```

5. **Disable `wpa_supplicant` Process:**

```bash

sudo systemctl stop wpa_supplicant

sudo systemctl disable wpa_supplicant

# Later: sudo systemctl mask wpa_supplicant (for hard stop)
```

6. **Fix SSH Key Conflict on Mac:**

```bash
ssh-keygen -R 192.189.156.120
# Reconnect to update known_hosts
```

7. **Comment Out Auto-wpa\_supplicant Launch:**

* Edit `/etc/network/interfaces` and comment out any lines that autostart `wpa_supplicant`

8. **Stress Test:**

* Performed 5 reboots. Verified that IP remains stable (e.g., 192.189.156.120) only **after** masking `wpa_supplicant` and removing DHCP-based IP churn.

### What I Learned


* `wpa_supplicant` can launch outside of NetworkManager and interfere.

* `mask` in `systemctl` completely disables the unit, redirecting it to `/dev/null`.

* DHCP client assigns dynamic IPs on reboot unless static configuration is forced.

* `ssh-keygen -R <ip>` is a lifesaver for known\_hosts mismatch.

* `/etc/network/interfaces` still matters in CLI-only Debian setups.

* `rfkill` is critical for diagnosing Wi-Fi module blocks.

---

✍ *Personal Note:*

This was an interesting experience, because I made a lot of unnecessary moves. Like with every beginning - just like in Kendo - before you can strike properly, you’ll make a bunch of mistakes. But all of them are worth it.
