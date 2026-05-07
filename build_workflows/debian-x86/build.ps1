$ErrorActionPreference = 'Stop'

dart pub global activate fastforge
$env:PATH = "$env:PATH:$HOME/.pub-cache/bin"

fastforge package --platform linux --targets deb

# dist/1.0.0+1/pwdgenf-1.0.0+1-linux.deb
