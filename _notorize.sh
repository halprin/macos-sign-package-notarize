#!/usr/bin/env bash

set -e

PATH_TO_FILE_TO_NOTARIZE=$1
APPLE_ID=$2
APP_SPECIFIC_PASSWORD=$3
APPLE_DEVELOPER_TEAM_ID=$4

echo ""
echo ""
echo "## Notarizing file $PATH_TO_FILE_TO_NOTARIZE for team $APPLE_DEVELOPER_TEAM_ID"
echo ""

xcrun notarytool submit "$PATH_TO_FILE_TO_NOTARIZE" --apple-id "$APPLE_ID" --password "$APP_SPECIFIC_PASSWORD" --team-id "$APPLE_DEVELOPER_TEAM_ID" --wait

echo ""
echo ""
echo "### Stapling notarization ticket to file $PATH_TO_FILE_TO_NOTARIZE"
echo ""

xcrun stapler staple "$PATH_TO_FILE_TO_NOTARIZE"
