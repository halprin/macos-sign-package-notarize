#!/usr/bin/env bash

set -e

PATH_TO_BINARY=$1
EXTRA_FILES=$2
ARCHIVE_DISK_NAME=$3
ARCHIVE_FILE_PATH=$4

ARCHIVE_PATH="/tmp/$ARCHIVE_DISK_NAME"

echo ""
echo ""
echo "## Creating $ARCHIVE_PATH"
echo ""

rm -rf "$ARCHIVE_PATH"
mkdir -p "$ARCHIVE_PATH"

echo ""
echo ""
echo "## Copying binary $PATH_TO_BINARY to $ARCHIVE_PATH"
echo ""

ditto "$PATH_TO_BINARY" "$ARCHIVE_PATH"

echo ""
echo ""
echo "## Copying files $EXTRA_FILES to $ARCHIVE_PATH"
echo ""

ditto $EXTRA_FILES "$ARCHIVE_PATH"

echo ""
echo ""
echo "## Creating disk image from $ARCHIVE_PATH to $ARCHIVE_FILE_PATH"
echo ""

rm -f "$ARCHIVE_FILE_PATH"

hdiutil create -srcFolder "$ARCHIVE_PATH" -o "$ARCHIVE_FILE_PATH"
