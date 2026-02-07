
📅 Date: 2025-08-14
🔧 Tools: USB with Debian 13

⸻

How It Started

It all started when I realized that my system, even after removing the GUI, was still heavy.
It was a great experience troubleshooting the issues that came after deleting the GUI along with a bunch of variables and caches.

I used sudo apt --purge and ended up losing SSH, drivers, and a bunch of other things.
I managed to fix most of them, but the system was already a mess.

So today, I rebooted and installed a fresh Debian 13 (light) on my server.

⸻

The Problem
	
	- Removed almost all network components.
	
	- Deleted drivers, especially ath10k_pci (internet-related).
	
	- Made a big mess in the file system.
	
	- Had trouble with a 5G Wifi connection — Debian 12 wouldn’t let me use my 5Gb internet because it wasn’t friendly with my drivers.

⸻

The Fix
	
	- Most file system issues were solved after spending a lot of time cleaning things up. I created one main directory for everything and built a tree with manuals and notes inside it.
	
	- The network was trickier — I had to use a USB stick, find the right driver manually, download it, and then set up wpa_supplicant & wpa_passphrase to create the first connection. After that, I installed Network Manager.
	
	- The 5G issue wasn’t completely solved. I replaced my firmware with a newer one, which gave me a 5G connection, but the speed was only 15 Mb/s.
	
	- In the end, I decided to completely erase the system. First, I created a tar -czf backup of the main directory and saved it to an external drive. Then I installed Debian 13 — now I’m building my environment from scratch, starting with a clean 1.4 GB base.

⸻

What I Learned
	
	- How to set up a network connection from scratch.
	
	- How to organize space better.
	
	- How to create a personalized environment.
	
	- How to use usermod to rename the server (did it twice).
	
	- Gained a deeper understanding of my system.
