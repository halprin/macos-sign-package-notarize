#!/usr/bin/env bash

set -e

# $PATH_TO_BINARIES - Path to the binaries to sign.
# $SIGNING_IDENTITY - The signing certificate identity used to sign the binary and DMG.

# $APPLE_ID - The Apple ID to login for notarization.  This and the next two inputs are required together, or app-store-connect-key and its next two inputs are required together.
# $APP_SPECIFIC_PASSWORD - The app-specific password used for the Apple ID for notarization.  This is a secret; make sure to pass in the value using GitHub Actions' secret functionality!
# $APPLE_DEVELOPER_TEAM_ID - The Apple developer team ID used in notarization.
# $APP_STORE_CONNECT_KEY - The base64 encoded version of the .p8 file from App Store Connect.  For notarization.  This and the next two inputs are required together, or apple-id and its next two inputs are required together.  This is a secret; make sure to pass in the value using GitHub Actions' secret functionality!
# $APP_STORE_CONNECT_KEY_ID - The key ID assigned to the key from App Store Connect.  For notarization.
# $APP_STORE_CONNECT_ISSUER_ID - The issuer ID assigned to your integrations in App Store Connect.  For notarization.

# $ARCHIVE_FILES - Space deliminated files to include in the DMG.
# $ARCHIVE_DISK_NAME - The name of the DMG disk volume.
# $ARCHIVE_FILE_PATH - The path where the DMG disk file is written.


echo ""
echo ""
echo "# Stamping (signing, archiving, and notarizing) for distribution"
echo ""

_sign.sh "$PATH_TO_BINARIES" "$SIGNING_IDENTITY"

_archive.sh "$ARCHIVE_FILES" "$ARCHIVE_DISK_NAME" "$ARCHIVE_FILE_PATH"

_sign.sh "$ARCHIVE_FILE_PATH" "$SIGNING_IDENTITY"

_notarize.sh "$ARCHIVE_FILE_PATH" "$APPLE_ID" "$APP_SPECIFIC_PASSWORD" "$APPLE_DEVELOPER_TEAM_ID" "$APP_STORE_CONNECT_KEY" "$APP_STORE_CONNECT_KEY_ID" "$APP_STORE_CONNECT_ISSUER_ID"

echo ""
echo ""
echo "# Stamping (signing, archiving, and notarizing) complete"
echo ""
