#!/bin/bash

# zowe_operations.sh

# Fail fast and show commands as they run
set -euo pipefail
set -x

# Ensure Zowe CLI is available
if ! command -v zowe >/dev/null 2>&1; then
  echo "Error: Zowe CLI not found. Install @zowe/cli before running this script."
  exit 127
fi

# Convert username to lowercase
LOWERCASE_USERNAME=$(echo "$ZOWE_USERNAME" | tr '[:upper:]' '[:lower:]')

# Check if directory exists, create if it doesn't
if ! zowe zos-files list uss-files "/z/$LOWERCASE_USERNAME/cobolcheck" &>/dev/null; then
  echo "Directory does not exist. Creating it..."
  zowe zos-files create uss-directory /z/$LOWERCASE_USERNAME/cobolcheck
else
  echo "Directory already exists."
fi

# Upload files
zowe zos-files upload dir-to-uss "./cobol-check" "/z/$LOWERCASE_USERNAME/cobolcheck" --recursive \
  --binary-files "cobol-check-0.2.9.jar"
# Verify upload
echo "Verifying upload:"
zowe zos-files list uss-files "/z/$LOWERCASE_USERNAME/cobolcheck"
