$ErrorActionPreference = 'Stop'
$buildWorkflowsPath = "./build_workflows/arch-x86"
$distPath = "./build/linux/x64/release/"

flutter build linux --release -v

Copy-Item -Path "$buildWorkflowsPath/pwdgenf.desktop.bak" -Destination "$distPath/pwdgenf.desktop.bak"
Copy-Item -Path "$buildWorkflowsPath/PKGBUILD" -Destination "$distPath/PKGBUILD"

makepkg -f
