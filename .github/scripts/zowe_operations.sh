#!/bin/bash

# zowe_operations.sh

# Fail fast and show commands as they run
set -euo pipefail

# Ensure Zowe CLI is available
if ! command -v zowe >/dev/null 2>&1; then
  echo "Error: Zowe CLI not found. Install @zowe/cli before running this script."
  exit 127
fi

# Convert username to lowercase
LOWERCASE_USERNAME=$(echo "$ZOWE_USERNAME" | tr '[:upper:]' '[:lower:]')

# Check if directory exists, create if it doesn't
if ! zowe zos-files list uss-files "/z/$LOWERCASE_USERNAME/cobolcheck" --zosmf-profile zprofile &>/dev/null; then
  echo "Directory does not exist. Creating it..."
  zowe zos-files create uss-directory /z/$LOWERCASE_USERNAME/cobolcheck --zosmf-profile zprofile
else
  echo "Directory already exists."
fi

# Upload files
JAR_PATH=$(find "./cobol-check/bin" -maxdepth 1 -name "*.jar" | head -n 1)
if [ -z "$JAR_PATH" ]; then
  echo "Error: No JAR found under ./cobol-check/bin."
  exit 1
fi
JAR_FILENAME=$(basename "$JAR_PATH")
export UPLOAD_DIR
UPLOAD_DIR=$(mktemp -d)
python - <<'PY'
import os
import shutil
from pathlib import Path

src = Path("cobol-check")
dst = Path(os.environ["UPLOAD_DIR"])

def ignore_jar(dir_path, names):
    rel = Path(dir_path).relative_to(src)
    if rel == Path("bin"):
        return [n for n in names if n.endswith(".jar")]
    return []

shutil.copytree(src, dst, ignore=ignore_jar, dirs_exist_ok=True)
PY
zowe zos-files upload dir-to-uss "$UPLOAD_DIR" "/z/$LOWERCASE_USERNAME/cobolcheck" --recursive \
  --zosmf-profile zprofile
zowe zos-files upload file-to-uss "$JAR_PATH" "/z/$LOWERCASE_USERNAME/cobolcheck/bin/$JAR_FILENAME" \
  --zosmf-profile zprofile \
  --binary

# Verify upload
echo "Verifying upload:"
zowe zos-files list uss-files "/z/$LOWERCASE_USERNAME/cobolcheck" --zosmf-profile zprofile
