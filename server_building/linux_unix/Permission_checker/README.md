# 🔐 permission_checker.sh

A simple Bash script to scan a specified directory for `.sh` files and add execution permissions

---

## 📂 How to Use

1. **Edit the target path in the script**:
   ```bash
   cd /home/user/Your_dir
   ```
   Replace this with your desired directory path.

2. **Make the script executable**:
  ```bash
   chmod +x permission_checker.sh
   ```

3. **Run the script**:
   ```bash
   ./permission_checker.sh
   ```
---
      
## ✅ What This Script Does

- Changes to the specified directory.
- Uses `find` to locate all files ending with `.sh`.
- Grants `744` permissions to each `.sh` file:
  - Owner: read, write, execute
  - Group: read
  - Others: read

---

## 💡 Note
- Make sure to have proper permissions for modifying files in the target directory.
- This script uses a basic `for` loop for compatibility with beginner-level Bash knowledge.
