# Homelab Weekly Backup Guard

<p align="center">
  <img src="../../assets/brain_readme.png" width="180">
</p>

<br>

A small Python automation for a self-hosted homelab. Once a week `cron` runs
[`auto_backup.py`](auto_backup.py), which makes sure the backup disk is mounted
and healthy before handing off to an existing bash backup script.

## What it does

Every Sunday the script:

1. **Checks the mount.** Is the backup disk mounted at the expected mount point?
2. **Mounts it if needed.** If the disk is plugged into a USB slot but not
   mounted, the script mounts it via its `/etc/fstab` entry (resolved by
   `UUID`, so the USB port does not matter).
3. **Verifies the disk.** Confirms a marker file is present (so it is really
   *your* backup disk, not a random USB stick) and that there is enough free
   space.
4. **Runs the backup.** Calls the existing bash backup script.
5. **Logs everything.** If the disk is not plugged in at all, or anything
   else fails, it writes an error to the log instead of silently doing nothing.

## Design notes

- **Mount by UUID, not by device name.** `/dev/sdb1` can change between boots or
  ports; a `UUID=` line in `/etc/fstab` is stable. The script only calls
  `mount <mount point>` and lets `fstab` resolve the rest.
- **Fail loud, in a log.** A backup that quietly does nothing is worse than one
  that errors, because you only find out when you need to restore. Every path
  through the script ends in a clear log line and a meaningful exit code.
- **Idempotent guard, not a backup engine.** The actual copying stays in the
  existing, tested bash script. This layer only decides *whether it is safe to
  run it*.

## Exit codes

| Code | Meaning                                             |
|------|-----------------------------------------------------|
| 0    | Backup ran successfully                             |
| 1    | Disk problem (not plugged in, cannot mount, wrong disk, no space) |
| 2    | The backup script itself failed                    |

## Setup

1. Add an `fstab` entry for the backup disk (find the UUID with `lsblk -f`):

   ```
   UUID=xxxx-xxxx  /mnt/backup  ext4  noauto,nofail  0  2
   ```

2. Mark the disk once so the script can recognise it:

   ```
   sudo touch /mnt/backup/.backup_target
   ```

3. Edit the `CONFIG` block at the top of `auto_backup.py` to match your paths.

4. Install the script and schedule it (mounting needs root):

   ```
   sudo cp auto_backup.py /usr/local/bin/
   sudo crontab -e     # add the line from crontab.example
   ```

## Development

Linting is enforced in CI with [ruff](https://docs.astral.sh/ruff/):

```
pip install ruff
ruff check .
ruff format --check .
```
