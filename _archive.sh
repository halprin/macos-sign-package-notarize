#!/usr/bin/env bash

set -e

ARCHIVE_FILES=$1
ARCHIVE_DISK_NAME=$2
ARCHIVE_FILE_PATH=$3

ARCHIVE_PATH="/tmp/$ARCHIVE_DISK_NAME"

echo ""
echo ""
echo "## Creating $ARCHIVE_PATH"
echo ""

rm -rf "$ARCHIVE_PATH"
mkdir -p "$ARCHIVE_PATH"

echo ""
echo ""
echo "## Copying files $ARCHIVE_FILES to $ARCHIVE_PATH"
echo ""

# Evaluates the \ escaped spaces so we correctly detect multiple files.
eval "set -- $ARCHIVE_FILES"

for CURRENT_FILE in "$@"; do
    echo "Copying file: $CURRENT_FILE"
    ditto "$CURRENT_FILE" "$ARCHIVE_PATH/$(basename "$CURRENT_FILE")"
done

echo ""
echo ""
echo "## Creating disk image from $ARCHIVE_PATH to $ARCHIVE_FILE_PATH"
echo ""

rm -f "$ARCHIVE_FILE_PATH"

hdiutil create -srcFolder "$ARCHIVE_PATH" -o "$ARCHIVE_FILE_PATH"
