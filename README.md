# macos-sign-package-notarize

Sign, package, and notarize macOS binaries.

This action will...
1. Sign the specified binaries.
2. Put the specified files into a DMG disk image.
3. Sign the DMG disk image.
4. Notarize the DMG disk image.

## Requirements

This GitHub Action requires a macOS runner.

## Usage

If you're using an app-specific password to authenticate...

```yaml
- uses: halprin/macos-sign-package-notarize@v2
  with:
    path-to-binaries: ./path/to/binary1 ./another\ path/to/binary2
    signing-identity: ${{ secrets.SIGNING_IDENTITY }}
    apple-id: ${{ secrets.APPLE_ID }}
    app-specific-password: ${{ secrets.APP_SPECIFIC_PASSWORD }}
    apple-developer-team-id: ${{ secrets.APPLE_DEVELOPER_TEAM_ID }}
    archive-files: ./path/to/binary1 ./another\ path/to/binary2 README.md LICENSE
    archive-disk-name: My macOS Program
    archive-file-path: ./my-macos-program.dmg
```

If you're using an App Store Connect key to authenticate...

```yaml
- uses: halprin/macos-sign-package-notarize@v2
  with:
    path-to-binaries: ./path/to/binary1 ./another\ path/to/binary2
    signing-identity: ${{ secrets.SIGNING_IDENTITY }}
    app-store-connect-key: ${{ secrets.APP_STORE_CONNECT_KEY }}
    app-store-connect-key-id: ${{ secrets.APP_STORE_CONNECT_KEY_ID }}
    app-store-connect-issuer-id: ${{ secrets.APP_STORE_CONNECT_ISSUER_ID }}
    archive-files: ./path/to/binary1 ./another\ path/to/binary2 README.md LICENSE
    archive-disk-name: My macOS Program
    archive-file-path: ./my-macos-program.dmg
```

Descriptions for these inputs are in [`action.yml`](action.yml).

Use GitHub secrets for the `app-specific-password` and `app-store-connect-key` inputs!  These values are sensitive and must not be revealed.

`app-store-connect-key` is supplied from a file you download from App Store Connect.  Run the following to get the value stored into the clipboard and ready for pasting into your GitHub Action secrets.

```shell
base64 -i ./AuthKey.p8 | pbcopy
```

## Other Useful Actions

The `signing-identity` references a certificate in the macOS Keychain.  This certificate can be imported using the [`apple-actions/import-codesign-certs` GitHub Action](https://github.com/Apple-Actions/import-codesign-certs) before running this repository's GitHub Action in a GitHub Action workflow.

You may want to upload the DMG disk image to a release's assets after running this repository's GitHub Action in a GitHub Action workflow.

```yaml
- name: Upload Release Asset
  run: gh release upload ${{ github.event.release.tag_name }} ./my-macos-program.dmg --clobber
  env:
    GH_TOKEN: ${{ github.token }}
```
