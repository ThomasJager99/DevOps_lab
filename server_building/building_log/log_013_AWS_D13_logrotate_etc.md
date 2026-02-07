📅 Date: 2025-08-29

🔧 Tools: AWS, Debian 13, Fail2ban, Logrotate, Docker, AlmaLinux, Apache, AWS S3, CloudFront, AWS CLI

________________

How It Started

I continued hardening my AWS server and setting up proper logging and monitoring. At the same time, I experimented with AlmaLinux in Docker to get a taste of corporate Linux environments. On the frontend side, I played with AI-generated React templates and finally connected AWS S3 with CloudFront to serve static files.

The Problem:

- Setting up fail2ban and logrotate required extra tweaking.
- After switching the SSH port, I initially locked myself out until I fixed both the AWS firewall rules and the server’s configs.
- AlmaLinux containers are extremely minimal — no passwd, no shadow-tools, no utilities.
- Apache cached a doomed image and refused to update it on the website.
- With S3 → I had to figure out how to keep my bucket private but still serve files publicly.

The Fix:

- Installed logrotate on AWS, set up fail2ban for SSH.
- Reinstalled htop and tmux on Debian 13 to make SSH work easier.
- Backed up and locked down SSH keys on an external drive.
- Adjusted SSH config → added rules in AWS firewall first, then updated the server configs. Learned about jail.d/sshd_config.d for persistent overrides.
- Spun up an AlmaLinux container (800 MB base) → installed passwd, shadow-tools, and basic utils with dnf.
- Fixed Apache image issue by replacing the faulty picture with a valid one.
- Set up AWS CLI on Mac, created a dedicated IAM user with keys, and configured ~/.zshrc for easier usage.
- Created private S3 bucket + CloudFront distribution → now static content (images, etc.) is served globally while keeping the bucket private.

What I Learned:

- Persistent SSH configs live in /etc/ssh/sshd_config.d/ and survive updates.
- AlmaLinux base containers are minimal — need to manually add tools.
- Apache may serve old/corrupted assets → sometimes it’s the file, not the cache.
- AWS best practice → never generate keys as root, always use IAM users.
- S3 + CloudFront combo = perfect way to serve static content privately but globally.

________________

Commands Used

# Logs cleanup on Debian
sudo journalctl --vacuum-size=200M

# Install logrotate
sudo apt install logrotate

# Fail2ban setup (Debian)
sudo apt install fail2ban

# Useful tools
sudo apt install htop tmux

# Change password utilities on AlmaLinux
sudo dnf install passwd shadow-tools

# AWS S3: upload/download files
aws s3 cp ./cat.png s3://my-bucket/cat.png
aws s3 ls s3://my-bucket

# AWS CloudFront: invalidate cache
aws cloudfront create-invalidation \
  --distribution-id <DIST_ID> \
  --paths "/*"

________________

✍ Personal Note:
Today I finally got the “aha moment” with S3 + CloudFront: private bucket as the source, CDN as the face. Feels good to see my site pulling images from “millions of warehouses around the world.”
