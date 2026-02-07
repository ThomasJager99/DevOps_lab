📅 Date: 2025-09-04

🔧 Tools: Cloudflare, Zoho Mail, AWS EC2, Elastic IP, Apache, Certbot (Let’s Encrypt)

________________


How It Started:

Today’s goal was to protect my website. I decided to start with Cloudflare and bought a domain name for my portfolio site. Cloudflare’s free plan also includes a free SSL certificate — a nice bonus.

________________


The Problem

To have a proper setup I needed:
- Email address for the domain
- DNS records for website + mail
- Static IP for my AWS instance
- SSL certificate installed directly on the server

The Fix

1. Domain + SSL via Cloudflare:
	
- Bought a domain on Cloudflare
- Activated free SSL included in the plan

2. Zoho Mail setup:

- Used Zoho’s free plan (5 GB/mailbox, up to 5 accounts)
- Authorized DNS with Zoho and added MX records (mx.zoho.eu)
- Configured priority levels (10 → 20 → 30) for redundancy
	
3. DNS Records:

- Added www as a CNAME alias
- Set MX for mail delivery
- Bound domain to AWS Elastic IP (so DNS won’t break after reboot)
	
4. Elastic IP:

- Allocated Elastic IP in AWS
- Attached it to the EC2 instance to prevent IP changes

5. SSL Certificate (Let’s Encrypt + Certbot):

- Installed certbot on the EC2 instance
- Generated SSL certificate with certbot
- Configured Apache to use HTTPS

What I Learned
- Cloudflare free plan already includes Universal SSL, but server-side SSL is still needed for full protection (Full mode).
- MX records define where domain mail goes, priority numbers ensure fallback order.
- Elastic IP is essential for stable DNS pointing to AWS.
- Certbot automates SSL certificate creation and Apache integration.
- Real setup = domain → Cloudflare proxy → AWS server with SSL.

________________

✍ Personal Note:
All of this was mostly for learning — now my portfolio website has HTTPS, custom email, and proper DNS setup. Feels like a real production-grade project already.
