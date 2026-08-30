flutter build linux --release -v

cp -Path "./build_workflows/arch-x86/pwdgenf.desktop.bak" -Destination "./build/linux/x64/release/pwdgenf.desktop.bak"
cp -Path "./build_workflows/arch-x86/PKGBUILD" -Destination "./build/linux/x64/release/PKGBUILD"

makepkg -f
