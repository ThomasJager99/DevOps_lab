📅 Date: 2025-08-23

🔧 Tools: nginx, Docker, GPG, shred, logrotate, AWS EC2, SSH, Apache

________________

How It Started

- Kept working on my local server and fixing the webpage.
- Started learning Docker on my Mac and explored file deletion concepts.
- Tried to configure logrotate on Debian.
- Decided to set up my first AWS Debian server as a playground for future portfolio work.

The Problem

- GitHub link on my local webpage pointed to a 404.
- Locale errors popped up every time I connected to the new AWS server.
- Logrotate configuration wasn’t clear at first.
- Learned that deleting files doesn’t actually erase them from HDD/SSD.

The Fix

- Fixed the broken GitHub link by editing /var/www/html/index.nginx.
- Studied secure file deletion:
- On HDD use:

shred -u -v -z filename.txt

- On SSD, due to TRIM, true deletion requires vendor-specific tools.
- Configured logrotate with custom adjustments.
- Installed Docker on Mac and, along the way, learned about GPG and key signatures.
- Set up the first AWS Debian server and fixed locale issues with:

sudo dpkg-reconfigure locales

choosing en_US.UTF-8.

- Planned next step: install and test Apache (httpd).
- Created an SSH config on Mac for easier access to servers:

Host aws
    HostName <Public-IP>
    User admin
    IdentityFile ~/.ssh/<path-to-key>.pem


What I Learned
- Sometimes errors are trivial — one line in the config can fix a 404.
- HDD vs SSD file deletion is fundamentally different: SSDs require special tools.
- Logrotate is essential to keep the system from flooding with logs.
- GPG and signatures are part of the foundation of secure software distribution.
- AWS Debian requires fixing locales manually.
- SSH config is a game-changer when working with multiple servers.

________________

✍ Personal Note:
Feels like I’m slowly building a “server zoo”: local Debian with nginx, AWS with Apache, and Docker on my Mac.

