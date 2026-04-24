#!/usr/bin/env bash
set -Eeuo pipefail

# === Config (override via env or .env) ===
BACKUP_BASE="${BACKUP_BASE:-/backup}"
INFRA="${INFRA:-/srv/infra}"
DATA="${DATA:-/srv/app_data}"

# Docker containers & DBs
PROD_CONTAINER="${PROD_CONTAINER:-prod_mysql}"
PROD_DB="${PROD_DB:-prod_db}"

DEV_CONTAINER="${DEV_CONTAINER:-custom_mysql}"
DEV_DB="${DEV_DB:-base}"

# MySQL password is expected to be provided via env:
# export MYSQL_ROOT_PASSWORD=...
: "${MYSQL_ROOT_PASSWORD:?MYSQL_ROOT_PASSWORD is required}"

# Retention
KEEP_SNAPSHOTS="${KEEP_SNAPSHOTS:-3}"

# Paths
LOG="${LOG:-$BACKUP_BASE/backup.log}"
CURRENT_INFRA="$BACKUP_BASE/infra"
CURRENT_DATA="$BACKUP_BASE/app_data"
VERSIONS="$BACKUP_BASE/versions"
SNAPSHOT="$VERSIONS/$(date +%F_%H-%M-%S)"

# === Helpers ===
log() { echo "[$(date '+%F %T')] $*"; }

cleanup_old() {
  log "Cleaning old snapshots (keep $KEEP_SNAPSHOTS)"
  # list newest first, skip first N, delete the rest
  ls -dt "$VERSIONS"/* 2>/dev/null | tail -n +"$((KEEP_SNAPSHOTS+1))" | xargs -r rm -rf
}

# === Start ===
mkdir -p "$CURRENT_INFRA" "$CURRENT_DATA" "$VERSIONS"

{
  log "=== MYSQL PROD DUMP ==="
  mkdir -p "$DATA/mysql_backup/mysql_prod"
  docker exec "$PROD_CONTAINER" \
    sh -c 'mysqldump -u root -p"$MYSQL_ROOT_PASSWORD" '"$PROD_DB" \
    > "$DATA/mysql_backup/mysql_prod/backup_$(date +%F_%H-%M-%S).sql"

  log "=== MYSQL DEV DUMP ==="
  mkdir -p "$DATA/mysql_backup/learn_mysql"
  docker exec "$DEV_CONTAINER" \
    sh -c 'mysqldump -u root -p"$MYSQL_ROOT_PASSWORD" '"$DEV_DB" \
    > "$DATA/mysql_backup/learn_mysql/backup_$(date +%F_%H-%M-%S).sql"

  log "=== RSYNC INFRA ==="
  rsync -a --delete --itemize-changes "$INFRA/" "$CURRENT_INFRA/"

  log "=== RSYNC DATA ==="
  rsync -a --delete --itemize-changes \
    --exclude 'mysql/' \
    "$DATA/" "$CURRENT_DATA/"

  log "=== CREATE SNAPSHOT ==="
  mkdir -p "$SNAPSHOT"
  rsync -a "$CURRENT_INFRA/" "$SNAPSHOT/infra/"
  rsync -a "$CURRENT_DATA/" "$SNAPSHOT/app_data/"

  log "Snapshot created: $SNAPSHOT"

  cleanup_old

  log "=== BACKUP END ==="

} >> "$LOG" 2>&1
