#!/bin/bash

BACKUP_BASE="/home/user/backupdir"
LOG="/home/user/backupdir/backup.log.md"

INFRA="/home/user/dir"
DATA="/home/user/application.data"

mkdir -p "$BACKUP_BASE/infra" "$BACKUP_BASE/app_data"
mountpoint -q "$BACKUP_BASE" || exit 1

{
echo "=== BACKUP START $(date) ==="

/usr/bin/rsync -avh --delete --itemize-changes "$INFRA/" "$BACKUP_BASE/infra/"
echo "--- infra rsync done ---"

/usr/bin/rsync -avh --delete --itemize-changes "$DATA/" "$BACKUP_BASE/app_data/"
echo "--- data rsync done ---"

echo "=== BACKUP END $(date) ==="
echo

} >> "$LOG" 2>&1
