Postmortem: Apache HTTPD and MediaWiki — Disk Space Shortage and Log Management

Incident Date: August 04–05, 2025
Affected Service: Apache HTTPD (MediaWiki instance on AWS EC2)
Downtime: ~40 minutes total (multiple restarts)

⸻

Incident Description

When trying to access the website via its URL, the MediaWiki web interface was unavailable. The Apache HTTPD server was still running but returned an error related to the $wgServer variable in the LocalSettings.php file.

Initial checks showed that the service was active, but further investigation revealed that the server’s disk space was almost completely full. The root cause was the /var/log/httpd/ directory, which was overloaded with .tar.gz archives of previous access_log files. These archives were being generated automatically by a cron job running with abnormally high frequency — once every minute — which quickly filled up the entire disk.

As a result, the MediaWiki web interface stopped responding correctly, and any attempt to modify configuration files failed with a “No space left on device” error.

⸻

Step-by-Step Resolution Process
	1. SSH connect to server
Connected to the EC2 instance.
	2. Check the web service status

sudo systemctl status httpd.service

Verified that the service was running.

	3. Restart the service

sudo systemctl restart httpd.service

No changes in behavior.

	4. Error when copying LocalSettings.php
Tried to copy LocalSettings.php into /var/www/html/mediawiki/ to replace the existing file.
Got a “No space left on device” error when using tab completion.
	5. Check free disk space

df -h /

Only 20 MB free out of 10 GB.

	6. Search for large files

sudo find / -type f -size +100M -exec du -h {} +

Found large Apache log archives.

	7. Delete old log files

sudo rm -rf /var/log/httpd/access_log-20250804
sudo rm -rf /var/log/httpd/log_202440402.tar.gz

Freed up ~7 GB.

	8. Check disk space again

df -h

7 GB free out of 10 GB.

	9. Copy the configuration file

cp LocalSettings.php /var/www/html/mediawiki/LocalSettings.php
ls -al /var/www/html/mediawiki/LocalSettings.php

Successfully replaced the file.

	10. Restart Apache

sudo systemctl restart httpd
sudo systemctl status httpd.service

Service is active.

	11. IP address mismatch
Accessing 3.69.26.193 redirected to 18.153.51.162.
Opened LocalSettings.php and found:

$wgServer = "http://18.153.51.162";

Changed to:

$wgServer = "http://3.69.26.193";

Restarted Apache.

	12. Inspect Apache logs

sudo ls -alh /var/log/httpd
sudo cat /var/log/httpd/access_log


	13. Check cron jobs

sudo crontab -l

Found a cron job archiving /var/log/httpd every minute.
Edited crontab:

sudo crontab -e

Commented out the job.

	14. Remove old archives
Bulk delete commands failed:

sudo rm -rf /var/log/httpd/*.tar.gz
sudo rm -rf /var/log/httpd/*.gz
sudo rm -rf /var/log/httpd/log*.gz

Deleted files manually:

sudo rm -rf /var/log/httpd/log_20250804.tar.gz


	15. Create a log management script
backup_log_httpd.sh:

#!/bin/bash
LOG_DIR="/var/log/httpd"
BACKUP_DIR="/home/ec2-user/backup/"
DATE=$(date "+%Y+%m+%d")
ARCH_NAME="$BACKUP_DIR/loghttp_$DATE.tar.gz"

mkdir -p "$BACKUP_DIR"
sudo tar -czf $ARCH_NAME $LOG_DIR

sudo systemctl stop httpd
#sleep 5
sudo rm -rf "$LOG_DIR/access_log"
#sleep 5
sudo systemctl start httpd

find "$BACKUP_DIR" -type f -name "loghttp*.tar.gz" -mtime +3 -exec rm -rf {} \;


	16. Test the script
	•	Ran manually.
	•	Switched -mtime to -cmin for accelerated testing.
	•	Confirmed that archives older than the set limit are deleted.

⸻

Lessons Learned
	1. Disk monitoring is essential — without logrotate or alerts, such problems will reoccur.
	2. Always check crontab for abnormal jobs when logs grow rapidly.
	3. Automated archive cleanup must have a retention policy.
	4. Replace hardcoded IP in MediaWiki $wgServer with a domain name to avoid AWS IP changes.

⸻

Prevention Plan
	• Configure logrotate for /var/log/httpd.
	• Add disk monitoring (CloudWatch or ncdu + cron).
	• Keep logs for only 3–7 days.
	• Configure MediaWiki to work via a domain instead of an IP.

⸻

P.S. This Postmortem is written in an educational format with step-by-step actions for training purposes.
In real production incidents, Postmortems are typically more concise, focusing only on the root cause, key actions, and specific technical details relevant to prevention.
