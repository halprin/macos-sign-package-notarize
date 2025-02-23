#!/usr/bin/env bash

set -e

PATH_TO_FILE_TO_NOTARIZE=$1

APPLE_ID=$2
APP_SPECIFIC_PASSWORD=$3
APPLE_DEVELOPER_TEAM_ID=$4

APP_STORE_CONNECT_KEY=$5
APP_STORE_CONNECT_KEY_ID=$6
APP_STORE_CONNECT_ISSUER_ID=$7


# Check if APP_STORE_CONNECT_KEY is not empty
if [ -n "$APP_STORE_CONNECT_KEY" ]; then
    echo ""
    echo ""
    echo "## Notarizing file $PATH_TO_FILE_TO_NOTARIZE using App Store Connect credentials"
    echo ""

    echo "$APP_STORE_CONNECT_KEY" | base64 --decode -o ./app_store_connect_key_file.p8

    set +e  # don't fail if the xcrun command fails because we want to delete the app_store_connect_key_file.p8 file.

    xcrun notarytool submit "$PATH_TO_FILE_TO_NOTARIZE" --key ./app_store_connect_key_file.p8 --key-id "$APP_STORE_CONNECT_KEY_ID" --issuer "$APP_STORE_CONNECT_ISSUER_ID" --wait

    rm ./app_store_connect_key_file.p8

    set -e  # re-enable failing when a command fails now that we deleted the app_store_connect_key_file.p8 file.
else
    echo ""
    echo ""
    echo "## Notarizing file $PATH_TO_FILE_TO_NOTARIZE using app-specific password credentials"
    echo ""

    xcrun notarytool submit "$PATH_TO_FILE_TO_NOTARIZE" --apple-id "$APPLE_ID" --password "$APP_SPECIFIC_PASSWORD" --team-id "$APPLE_DEVELOPER_TEAM_ID" --wait
fi


echo ""
echo ""
echo "### Stapling notarization ticket to file $PATH_TO_FILE_TO_NOTARIZE"
echo ""

xcrun stapler staple "$PATH_TO_FILE_TO_NOTARIZE"
