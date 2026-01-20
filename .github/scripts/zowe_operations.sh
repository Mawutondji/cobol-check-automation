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

# Fast connectivity check to fail early if the host is slow or unreachable
timeout 60s zowe zosmf check status --zosmf-profile zprofile

# Check if directory exists, create if it doesn't
if ! timeout 60s zowe zos-files list uss-files "/z/$LOWERCASE_USERNAME/cobolcheck" --zosmf-profile zprofile &>/dev/null; then
  echo "Directory does not exist. Creating it..."
  timeout 60s zowe zos-files create uss-directory /z/$LOWERCASE_USERNAME/cobolcheck --zosmf-profile zprofile
else
  echo "Directory already exists."
fi

# Upload files
timeout 300s zowe zos-files upload dir-to-uss "./cobol-check" "/z/$LOWERCASE_USERNAME/cobolcheck" --recursive \
  --zosmf-profile zprofile \
  --binary-files "bin/*.jar"
# Verify upload
echo "Verifying upload:"
timeout 60s zowe zos-files list uss-files "/z/$LOWERCASE_USERNAME/cobolcheck" --zosmf-profile zprofile
