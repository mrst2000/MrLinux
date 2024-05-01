#!/bin/bash

sudo apt-get install fuse -y

cp -r linux64 MrLinux.AppDir

# The file for Appimage

rm MrLinux.AppDir/launcher

cat >MrLinux.AppDir/MrLinux.desktop <<-EOF
[Desktop Entry]
Name=MrLinux
Exec=echo "MrLinux started"
Icon=nekoray
Type=Application
Categories=Network
EOF

cat >MrLinux.AppDir/AppRun <<-EOF
#!/bin/bash
echo "PATH: \${PATH}"
echo "MrLinux runing on: \$APPDIR"
LD_LIBRARY_PATH=\${APPDIR}/usr/lib QT_PLUGIN_PATH=\${APPDIR}/usr/plugins \${APPDIR}/MrLinux -appdata "\$@"
EOF

chmod +x MrLinux.AppDir/AppRun

# build

curl -fLSO https://github.com/AppImage/AppImageKit/releases/latest/download/appimagetool-x86_64.AppImage
chmod +x appimagetool-x86_64.AppImage
./appimagetool-x86_64.AppImage MrLinux.AppDir

# clean

rm appimagetool-x86_64.AppImage
rm -rf MrLinux.AppDir
