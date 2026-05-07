$ErrorActionPreference = 'Stop'
$buildWorkflowsPath = "./build_workflows/android"
$distPath = "./build/app/outputs/flutter-apk/"

flutter build apk --release --split-per-abi -v
