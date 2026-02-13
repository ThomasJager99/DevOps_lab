#!/bin/bash

BACKUP_BASE="/home/user/backupdir"
LOG="/home/user/backupdir/backup.log.md"

INFRA="/home/user/dir"
DATA="/home/user/application.data"

mkdir -p "$BACKUP_BASE/infra" "$BACKUP_BASE/app_data"
mkdir -p "$DATA/mysql_backup"

mountpoint -q "$BACKUP_BASE" || exit 1

{
echo "=== BACKUP START $(date) ==="

echo "--- mysql dump ---"
/usr/bin/docker exec mysql_db \
  sh -c 'mysqldump -u root -p"$MYSQL_ROOT_PASSWORD" appdb' \
  > "$DATA/mysql_backup/backup_mysql_$(date +%F_%H-%M-%S).sql"

echo "--- mysql dump done ---"

/usr/bin/rsync -avh --delete --itemize-changes \
"$INFRA/" "$BACKUP_BASE/infra/"

echo "--- infra rsync done ---"

/usr/bin/rsync -avh --delete --itemize-changes \
--exclude 'mysql_data/' \
"$DATA/" "$BACKUP_BASE/app_data/"

echo "--- data rsync done ---"

echo "=== BACKUP END $(date) ==="
echo

} >> "$LOG" 2>&1
