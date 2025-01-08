#!/usr/bin/env bash

set -e

PATH_TO_BINARY=$1
SIGNING_IDENTITY=$2
APPLE_ID=$3
APP_SPECIFIC_PASSWORD=$4
APPLE_DEVELOPER_TEAM_ID=$5
EXTRA_FILES=$6
ARCHIVE_DISK_NAME=$7
ARCHIVE_FILE_PATH=$8

echo ""
echo ""
echo "# Stamping (signing, archiving, and notarizing) binary $PATH_TO_BINARY for distribution"
echo ""

./_sign.sh "$PATH_TO_BINARY" "$SIGNING_IDENTITY"

./_archive.sh "$PATH_TO_BINARY" "$EXTRA_FILES" "$ARCHIVE_DISK_NAME" "$ARCHIVE_FILE_PATH"

./_sign.sh "$ARCHIVE_FILE_PATH" "$SIGNING_IDENTITY"

./_notorize.sh "$ARCHIVE_FILE_PATH" "$APPLE_ID" "$APP_SPECIFIC_PASSWORD" "$APPLE_DEVELOPER_TEAM_ID"

echo ""
echo ""
echo "# Stamping (signing and notarizing) complete for binary $PATH_TO_BINARY"
echo ""
