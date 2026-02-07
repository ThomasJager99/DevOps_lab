A bit of context…

I first discovered Linux a little over 3 months ago — and honestly, it was love at first boot.
From the very beginning, I chose Ubuntu, the most beginner-friendly distro, and started exploring everything I could get my hands on: SSH, Nginx, UFW… you name it.

For the first few weeks, it felt like I had entered a new world.

But after a month of living in Linux day and night, it started to feel… easy.
Too easy.

I realized I wanted more control. A cleaner, more focused environment.
That’s when I started looking into alternatives — something closer to the bare metal, but still stable.

After some research, I settled on Debian 12.
It felt like the right choice for my learning goals and the server project I had in mind.

So, I made the jump.
⸻

Log 001

⚙Week 1 — Distro Migration: Ubuntu → Debian 12

Background:
	•	First contact with Linux: ~3 months ago
	•	Initial distro: Ubuntu (for accessibility and package availability)
	•	Explored basics: SSH, Nginx, UFW, local networking

Motivation to switch:
	•	Ubuntu became too “user-friendly” for learning deeper system control
	•	Wanted a cleaner, more minimal system
	•	Seeking full control for headless server setup

Decision:
	•	Switched to Debian 12
	•	Chosen for:
	•	Stability
	•	Better suitability for terminal-based workflows
	•	Educational value for learning real Linux internals

Status:
Migration complete. Debian is now the base OS for server experiments.


LOG 002

Install Process:
	•	Ubuntu removed
	•	Debian 12 installed (successful on 3rd attempt)
	•	Chosen for lightweight footprint (~5 GB with minimal GUI)
	•	GUI kept temporarily for orientation (XFCE)

Wi-Fi Issue:
	•	5GHz reception broken due to hostapd update
	•	Conflict between access point tools and receiver module
	•	Hardware supports 5GHz, but driver setup unstable

Initial Configuration:
	•	SSH Remote Access enabled
	•	Performance mode set via CLI
	•	Root access used to grant sudo to user (sudoers config missing by default)
	•	Initial SSH connection unstable — high packet loss

Next Steps:
	•	Transition to full headless setup
	•	Investigate hostapd conflict
	•	Begin Docker setup and scripting tools

Status: Debian system installed, partially configured. Further tuning in progress.

LOG 003

Test:
	•	Source: ~/scripts/ directory on Ubuntu
	•	Contents: mostly shell scripts in nested folders
	•	Packed into tar.zip archive
	•	Transferred to Debian system and unpacked

Observation:
	•	On Ubuntu: archive size ~68 MB
	•	On Debian (unpacked): directory size ~7.2 MB
	•	No visible difference in files or structure

Conclusion:
	•	Ubuntu system likely added extended attributes, hidden metadata, cache or indexing data to file structures
	•	Debian maintains a cleaner FS footprint on identical data

Takeaway: Debian provides significantly leaner storage behavior for plain-text scripts and directories. Useful for minimal setups or scripting environments.

LOG 004

Server identity and hostname updated.

I’ve decided to name my personal development server.
The machine is a six-year-old laptop with the following specs:
	•	Intel Core i5
	•	120 GB SSD
	•	20 GB DDR4 RAM (manually upgraded)

While working with it on a daily basis — SSH, packages, configurations — I realized that naming the machine would be a meaningful step.
From this point forward, the hostname and identity are set to:

makko@kujira
(kujira = クジラ = whale in Japanese, specifically referring to the sperm whale: マッコウクジラ / makko kujira)

Hostname, prompt, and system references have been updated accordingly.

This marks the beginning of my server journey.

![whale](../Assets/img/whale.png)


LOG 005

Power state inconsistencies and crontab/rtcwake issues

Recently attempted to automate power management on my Debian server: wake at 6:00 AM, shut down at 00:00.

Steps taken:
	•	Created a root-level crontab job to use rtcwake
	•	Target: rtcwake -l -m no -t [timestamp]
	•	Simultaneously scheduled shutdown via sudo poweroff

Observed issues:
	•	rtcwake did not correctly set the wake timer via crontab
	•	System stayed powered on through the night
	•	Only user-level crontab messages (like greetings) executed as expected

Additional problem encountered:
	•	After full shutdown via poweroff, the server powers on ~10 minutes later with only the LED on — no POST or boot
	•	System appears stuck in an undefined power state

Temporary solutions:
	•	Disabled Wake-on-LAN in BIOS
	•	Cleaned and adjusted crontab entries for both root and user

Conclusion:
Current automation using crontab and rtcwake is unreliable.
Will research and eventually implement custom system daemons for robust control.

Additional:
After some digging, I found the main reason my server wasn’t sleeping/waking on time — a misconfigured root crontab.

I updated my script and discovered a neat feature:

date -d "Tomorrow 6:00" +%s

This returns a timestamp for 6:00 AM tomorrow. The -d flag surprisingly accepts natural language inputs like "next Friday", which seems to be a GNU/Linux-specific thing — quite handy.

I manually tested this logic:
	•	Scheduled wake-up for 7 minutes later
	•	Set sleep in 20 seconds
	•	Verified wakealarm log — it worked

Then I rewrote the root crontab like this:

58 23 * * * /home/makko/dir/dir/sleep.script.sh >> /home/makko/sleep_log.md 2>&1

Now both stdout and stderr are logged, so I can debug directly if anything fails.

We’ll see if this new setup behaves better.


LOG 006

Issue:
crontab under root failed to execute scheduled sleep/wake script due to missing PATH environment.

Symptoms:
	•	Script worked manually (sudo ./sleep.sh)
	•	Cron triggered suspend, but failed to locate rtcwake:
rtcwake: command not foud

Diagnosis:
Cron runs in a limited environment and does not inherit user-defined environment variables (like those in .bashrc or .profile). As a result, its $PATH is incomplete.

Steps Taken:
	1.	Verified $PATH via echo $PATH in normal terminal and compared it to cron.
	2.	Identified that rtcwake is located in /usr/sbin which was missing from cron’s path.
	3.	Added full path export directly in the script:
Result:
	•	Script now sets wake timer and system enters suspend mode correctly.
	•	System wakes up at the intended time (e.g. 06:30) using rtcwake.

Conclusion:
Always ensure critical binaries are included in $PATH when executing scripts via crontab, especially under root. Cron’s limited environment requires explicit context setup.

Plan: 
	– Add a 20-minute warning before shutdown.
	(The laptop shut down last night while I was working — forgot about the crontab.)


LOG 007

Lid closed, system alive — configuring logind.conf

Task: Prevent the server (a repurposed laptop) from suspending when the lid is closed.

Steps:
1.	Switched to root.
	
2.	Edited the config file:
/etc/systemd/logind.conf

3.	Found this line (commented by default):
#HandleLidSwitch=suspend

4.	Uncommented it and changed value to:
HandleLidSwitch=ignore

5.	Rebooted system.

Result:
Now, the machine stays fully functional with the lid closed. SSH sessions stay alive, workflows uninterrupted.

Also explored /sys/class/power_supply/BAT1/ for battery monitoring:
	•	capacity — battery percentage
	•	status — current charging state


LOG 008

Startup monitor script via .bashrc

Implemented a custom Bash script that runs every time the terminal is launched (via ~/.bashrc). While it’s not a daemon, it acts as a simple visual status dashboard.

Functionality includes:
	•	Welcome message on shell launch
	•	Battery level readout
	•	Charging status (Charging, Discharging, or Full)
	•	CPU model info
	•	Core temperature and voltage reporting
	•	Basic network diagnostics (ping to laptop and router with ping -c 5)

Notes:
	•	The ping -c flag allows for fixed-length diagnostics — clearer output for terminal-based checks
	•	Output design (colors, formatting) took significantly longer than the actual logic

Goal:
Create a personal visual health-check system for the server — lightweight, non-intrusive, and tailored for manual inspection.
Future plans: turn this into a daemon for background monitoring and automated alerts.
