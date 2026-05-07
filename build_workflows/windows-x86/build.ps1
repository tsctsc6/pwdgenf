$ErrorActionPreference = 'Stop'
$buildWorkflowsPath = "./build_workflows/windows-x86"
$distPath = "./build/windows/x64/runner/Release"

flutter build windows --release -v

$version = yq .version pubspec.yaml
$version = $version.Split("+")[0]

Copy-Item -Path "$buildWorkflowsPath/.wxs" -Destination "$distPath/pwdgenf-x86-v$version.wxs"
Copy-Item -Path "$buildWorkflowsPath/vcrt.ps1" -Destination "$distPath/vcrt.ps1"

Set-Location -Path $distPath
./vcrt.ps1

dotnet tool install --global wix
wix eula accept wix7
wix extension add WixToolset.UI.wixext
wix build "pwdgenf-x86-v$version.wxs" -d BuildVersion=$version -ext WixToolset.UI.wixext -v

Set-Location -Path ../../../../..
