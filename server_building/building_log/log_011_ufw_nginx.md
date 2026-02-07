📅 Date: 2025-08-16

🔧 Tools: ufw, nginx, apt, systemctl

________________

How It Started:

The idea was to install UFW, allow the necessary ports, and install nginx — then put something on it to test locally in browser.

________________

The Fix:

1. Install simple firewall — UFW

sudo apt update && sudo apt install ufw

Installation went successfully, nothing to complain about.
I allowed port 22 to maintain SSH connection and did it before enabling the firewall, like a smart move:

sudo ufw allow 22

This added a new rule: SSH is allowed.
And what I really like about UFW is its default policy — everything is denied unless allowed.


2. Allow nginx to talk to the browser
Before enabling the firewall, I allowed another port:

sudo ufw allow 80

This is needed for HTTP.


3. Install and set up the web service — nginx:

sudo apt install nginx
sudo systemctl start nginx
sudo systemctl enable nginx

Although enable might not be necessary — after installation, nginx was already set to autostart on boot (as seen in systemctl status).


4. Result:

After a couple of iterations, I managed to create a small useful website — with all the links I need for my study.
A small win for me. But it’s the foundation for future things.

_______________


What I Learned

• Always allow SSH before enabling the firewall.

• ufw is dead simple and efficient — good choice for minimal systems.

• nginx installs fast and works out of the box.

• Port 80 should be explicitly opened with ufw allow 80.

• Even minimal Debian is capable of serving something useful in a couple of minutes.


✍ Personal Note:
Little win for me. From here, I’ll build up to more.
