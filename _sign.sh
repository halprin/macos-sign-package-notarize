#!/usr/bin/env bash

set -e

PATH_TO_FILES_TO_SIGN=$1
SIGNING_IDENTITY=$2

echo ""
echo ""
echo "## Code signing file $PATH_TO_FILES_TO_SIGN with signing identity $SIGNING_IDENTITY"
echo ""

# Evaluates the \ escaped spaces so we correctly detect multiple files.
eval "set -- $PATH_TO_FILES_TO_SIGN"

codesign --verbose --sign "$SIGNING_IDENTITY" --force --timestamp --deep -o runtime "$@"
