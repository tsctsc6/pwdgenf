$ErrorActionPreference = 'Stop'

flutter build apk --release --target-platform android-arm64 --split-per-abi -v

# Platforms: android-arm64, android-arm, android-x64
