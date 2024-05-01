#!/bin/bash

version="$1"

mkdir -p MrLinux/DEBIAN
mkdir -p MrLinux/opt
cp -r linux64 MrLinux/opt/
mv MrLinux/opt/linux64 MrLinux/opt/MrLinux
rm -rf MrLinux/opt/MrLinux/usr
rm MrLinux/opt/MrLinux/launcher

# basic
cat >MrLinux/DEBIAN/control <<-EOF
Package: MrLinux
Version: $version
Architecture: amd64
Maintainer: MatsuriDayo nekoha_matsuri@protonmail.com
Depends: libxcb-xinerama0, libqt5core5a, libqt5gui5, libqt5network5, libqt5widgets5, libqt5svg5, libqt5x11extras5, desktop-file-utils
Description: Qt based cross-platform GUI proxy configuration manager (backend: v2ray / sing-box)
EOF

cat >MrLinux/DEBIAN/postinst <<-EOF
if [ ! -s /usr/share/applications/MrLinux.desktop ]; then
    cat >/usr/share/applications/MrLinux.desktop<<-END
[Desktop Entry]
Name=MrLinux
Comment=Qt based cross-platform GUI proxy configuration manager (backend: Xray / sing-box)
Exec=sh -c "PATH=/opt/MrLinux:\$PATH /opt/MrLinux/MrLinux -appdata"
Icon=/opt/MrLinux/nekoray.png
Terminal=false
Type=Application
Categories=Network;Application;
END
fi

setcap cap_net_admin=ep /opt/MrLinux/nekobox_core

update-desktop-database
EOF

sudo chmod 0755 MrLinux/DEBIAN/postinst

# desktop && PATH

sudo dpkg-deb -Zxz --build MrLinux
