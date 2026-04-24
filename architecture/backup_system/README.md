# Backup Tools
This directory contains backup scripts and related tooling used to maintain data integrity and ensure recoverability across the infrastructure.
The goal of this module is to provide a simple, reproducible, and controlled backup system for both application data and infrastructure components.

---

## Overview
The backup system is designed around:
- Regular data synchronization
- Database dumps
- Versioned snapshots
- Controlled retention policy
It combines `rsync` for file-level backups with additional logic for snapshot creation and cleanup.

---

## Structure

backup_tools/
├── bash/
│   └── backup.sh
├── pyth

---

## Functionality
The backup scripts provide:
- MySQL database dumps from Docker containers
- Incremental file synchronization using `rsync`
- Snapshot-based versioning of backups
- Automatic cleanup of older snapshots
- Logging of backup operations
---

## Backup Strategy

The system follows a hybrid approach:

### Current State

/backup/infra
/backup/app_data

Maintained using:
- `rsync --delete` to reflect the latest state

---

### Snapshots

/backup/versions/YYYY-MM-DD_HH-MM/

Each snapshot represents a full state of the system at a specific point in time.
Snapshots are:
- Created after each backup run
- Stored as separate directories
- Limited to a fixed number (default: 3)

---

## Retention Policy
- Only the most recent snapshots are kept
- Older snapshots are automatically removed
- This prevents uncontrolled disk usage while preserving rollback capability

---

## Use Cases
- Restore accidentally deleted files
- Roll back to a previous known-good state
- Inspect historical changes in configuration or data
- Provide safety during infrastructure changes

---

## Notes
- All paths, identifiers, and credentials are sanitized
- Scripts are environment-dependent and require adaptation before use
- Backup integrity depends on correct configuration and periodic verification

---

## Scheduled Backups (cron)
Example `crontab` entry to run the backup script daily:

0 3 * * * /path/to/backup_tools/bash/backup.sh >> /var/log/backup.log 2>&1

### Explanation
- `0 3 * * *` — runs every day at 03:00
- Script path should be adjusted to your environment
- Output is appended to a log file for later inspection

---

### Optional: Weekly Backup

0 2 * * 0 /path/to/backup_tools/bash/backup.sh >> /var/log/backup.log 2>&1

- Runs every Sunday at 02:00

---

### Notes
- Ensure the script has execute permissions:

chmod +x backup.sh

- It is recommended to run backups during low system activity
- Logs should be rotated using `logrotate`

---

## Disclaimer
This backup system is designed for controlled environments and self-hosted infrastructure.
It prioritizes simplicity and transparency over complex enterprise-grade solutions.
