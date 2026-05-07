$vsPath = &"${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe" `
    -latest -products * -property installationPath

$redistRoot = Join-Path $vsPath "VC\Redist\MSVC"

$latestVersion = Get-ChildItem -Path $redistRoot | Where-Object { ($_.Name.Length -gt 4) } | Sort-Object Name -Descending | Select-Object -First 1

$crtPath = Join-Path $latestVersion.FullName "x64\Microsoft.VC14*.CRT"

$dlls = @("msvcp140.dll", "vcruntime140.dll", "vcruntime140_1.dll")
foreach ($dll in $dlls) {
    $source = Get-ChildItem -Path $crtPath -Filter $dll -Recurse | Select-Object -First 1
    if ($source) {
        Copy-Item $source.FullName -Destination "./" -Force
        Write-Host "Copied: $($source.FullName)"
    } else {
        Write-Error "$dll not found"
    }
}
