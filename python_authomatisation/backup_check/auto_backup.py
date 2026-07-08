#!/usr/bin/env python3
"""Weekly homelab backup guard.

Runs from cron every Sunday. Makes sure the backup disk is mounted at the
expected mount point, sanity-checks that it is really the right disk with
enough free space, and only then hands off to the existing bash backup
script. Everything that happens is written to a log file so a failed run
can be diagnosed after the fact.

Exit codes:
    0  backup ran successfully
    1  disk problem (not plugged in, cannot mount, wrong disk, no space)
    2  the backup script itself failed
"""

from __future__ import annotations

import logging
import os
import shutil
import subprocess
import sys

# --------------------------------------------------------------------------
# CONFIG -- edit these for your real homelab. Everything below is a template.
# --------------------------------------------------------------------------

# Where the disk should end up mounted. There must be a matching line in
# /etc/fstab that mounts the disk here by UUID, e.g.:
#   UUID=xxxx-xxxx  /mnt/backup  ext4  noauto,nofail  0  2
# With that line in place, `mount /mnt/backup` finds the disk by UUID no
# matter which USB port it is plugged into.
MOUNT_POINT = "/mnt/backup"

# Your existing bash backup script.
BACKUP_SCRIPT = "/usr/local/bin/backup.sh"

# Where this Python script writes its log.
LOG_FILE = "/var/log/homelab_backup.log"

# A marker that must exist on the disk. It proves the mounted volume is
# actually YOUR backup disk and not some random USB stick that happened to
# grab the mount point. Create it once with e.g. `touch /mnt/backup/.backup_target`.
MARKER = ".backup_target"

# Minimum free space required before we bother running the backup (GiB).
MIN_FREE_GIB = 5

# --------------------------------------------------------------------------


logger = logging.getLogger("homelab_backup")


def setup_logging() -> None:
    """Log to both the log file and stderr (stderr shows up in cron mail)."""
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s %(levelname)s %(message)s",
        handlers=[
            logging.FileHandler(LOG_FILE),
            logging.StreamHandler(sys.stderr),
        ],
    )


def is_mounted(path: str) -> bool:
    """True if `path` is a mount point (something is mounted there)."""
    return os.path.ismount(path)


def try_mount(path: str) -> bool:
    """Attempt to mount `path` using its /etc/fstab entry.

    Returns True on success. Relies on there being an fstab line for this
    mount point, so we only pass the mount point and let mount(8) resolve
    the UUID and options.
    """
    logger.info("Disk not mounted at %s, attempting to mount...", path)
    result = subprocess.run(
        ["mount", path],
        capture_output=True,
        text=True,
        check=False,
    )
    if result.returncode == 0:
        logger.info("Mount succeeded.")
        return True

    logger.error(
        "Mount failed (rc=%s). Is the disk plugged in? stderr: %s",
        result.returncode,
        result.stderr.strip(),
    )
    return False


def verify_disk(path: str) -> bool:
    """Confirm the mounted disk is the right one and has room to spare."""
    marker_path = os.path.join(path, MARKER)
    if not os.path.exists(marker_path):
        logger.error(
            "Marker %s not found -- the mounted volume is not the backup disk.",
            marker_path,
        )
        return False

    free_gib = shutil.disk_usage(path).free / (1024**3)
    if free_gib < MIN_FREE_GIB:
        logger.error(
            "Only %.1f GiB free, need at least %d GiB. Aborting.",
            free_gib,
            MIN_FREE_GIB,
        )
        return False

    logger.info("Disk verified: marker present, %.1f GiB free.", free_gib)
    return True


def run_backup(script: str) -> bool:
    """Run the existing bash backup script; True if it exits cleanly."""
    logger.info("Starting backup script: %s", script)
    result = subprocess.run([script], check=False)
    if result.returncode == 0:
        logger.info("Backup script finished successfully.")
        return True

    logger.error("Backup script failed (rc=%s).", result.returncode)
    return False


def main() -> int:
    setup_logging()
    logger.info("=== Weekly backup run started ===")

    # 1. Make sure the disk is mounted, mounting it if we have to.
    if not is_mounted(MOUNT_POINT):
        if not try_mount(MOUNT_POINT):
            logger.error("Could not mount the disk. Nothing to back up.")
            return 1
    else:
        logger.info("Disk already mounted at %s.", MOUNT_POINT)

    # 2. Make sure it is the right disk with enough space.
    if not verify_disk(MOUNT_POINT):
        return 1

    # 3. Hand off to the real backup script.
    if not run_backup(BACKUP_SCRIPT):
        return 2

    logger.info("=== Weekly backup run finished OK ===")
    return 0


if __name__ == "__main__":
    sys.exit(main())
