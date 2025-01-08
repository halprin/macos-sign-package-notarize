#!/usr/bin/env bash

set -e

PATH_TO_FILE_TO_SIGN=$1
SIGNING_IDENTITY=$2

echo ""
echo ""
echo "## Code signing file $PATH_TO_FILE_TO_SIGN with signing identity $SIGNING_IDENTITY"
echo ""

codesign --verbose --sign "$SIGNING_IDENTITY" --force --timestamp -o runtime "$PATH_TO_FILE_TO_SIGN"
