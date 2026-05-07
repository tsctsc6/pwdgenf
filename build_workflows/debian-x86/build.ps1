$ErrorActionPreference = 'Stop'

dart pub global activate fastforge
$env:PATH = "$($env:PATH):$HOME/.pub-cache/bin"

fastforge package --platform linux --targets deb --flutter-build-args=verbose
