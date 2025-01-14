# macos-sign-package-notarize

Sign, package, and notarize macOS binaries.

This action will...
1. Sign the specified binary.
2. Put the signed binary, along with any extra files, into a DMG disk image.
3. Sign the DMG disk image.
4. Notarize the DMG disk image.

## Requirements

This GitHub Action requires a macOS runner.

## Usage

If you're using an app-specific password to authenticate...

```yaml
- uses: halprin/macos-sign-package-notarize@v1
  with:
    path-to-binary: ./evn-pilot-conversion
    signing-identity: ${{ secrets.SIGNING_IDENTITY }}
    apple-id: ${{ secrets.APPLE_ID }}
    app-specific-password: ${{ secrets.APP_SPECIFIC_PASSWORD }}
    apple-developer-team-id: ${{ secrets.APPLE_DEVELOPER_TEAM_ID }}
    extra-files: README.md LICENSE
    archive-disk-name: My macOS Program
    archive-file-path: ./my-macos-program.dmg
```

If you're using an App Store Connect key to authenticate...

```yaml
- uses: halprin/macos-sign-package-notarize@v1
  with:
    path-to-binary: ./evn-pilot-conversion
    signing-identity: ${{ secrets.SIGNING_IDENTITY }}
    app-store-connect-key: ${{ secrets.APP_STORE_CONNECT_KEY }}
    app-store-connect-key-id: ${{ secrets.APP_STORE_CONNECT_KEY_ID }}
    app-store-connect-issuer-id: ${{ secrets.APP_STORE_CONNECT_ISSUER_ID }}
    extra-files: README.md LICENSE
    archive-disk-name: My macOS Program
    archive-file-path: ./my-macos-program.dmg
```

Descriptions for these inputs are in [`action.yml`](action.yml).

Use GitHub secrets for the `app-specific-password` and `app-store-connect-key` inputs!  These values are sensitive and must not be revealed.

## Other Useful Actions

The `signing-identity` references a certificate in the macOS Keychain.  This certificate can be imported using the [`apple-actions/import-codesign-certs` GitHub Action](https://github.com/Apple-Actions/import-codesign-certs) before running this repository's GitHub Action in a GitHub Action workflow.

You may want to upload the DMG disk image to a release's assets after running this repository's GitHub Action in a GitHub Action workflow.

```yaml
- name: Upload Release Asset
  run: gh release upload ${{ github.event.release.tag_name }} ./my-macos-program.dmg --clobber
  env:
    GH_TOKEN: ${{ github.token }}
```
