#!/bin/bash
smbusername = 'stony'
smbpassword = 'euclid1337'

echo "=== Packages ==="
echo "================"
echo ">>> Updating packages"
sudo pacman -Syu
yay -Syu

echo ">>> Setting Up Audio"
sudo pacman -Sq yay manjaro-pulse pavucontrol

echo ">>> Setting up AMDGPU"
sudo pacman -Sq lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader
sudo pacman -Sq lib32-gnutls lib32-libldap lib32-libgpg-error lib32-sqlite lib32-libpulse
sudo pacman -Sq wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader

echo ">>> Setting up Decklink"
sudo pacman -Sq dkms
yay -Sq decklink

echo ">>> Setting up v4l2loopback"
yay -Sq v4l2loopback-dkms obs-v4l2sink

echo ">>> Installing VS Code"
yay -Sq visual-studio-code-bin 

echo ">>> Installing BalenaEtcher"
yay -Sq balena-etcher

echo ">>> Installing Opera"
yay -Sq opera

echo ">>> Installing Rofi"
yay -Sq rofi

echo ">>> Installing Discord"
yay -Sq discord

echo ">>> Installing Twitch"
yay -Sq twitch 

echo ">>> Installing Lutris and Steam"
sudo pacman -Sq lutris steam

echo ">>> Installing FreeFileSync"
yay -Sq freefilesync

echo ">>> Installing Remmina"
sudo pacman -Sq freerdp remmina

echo ">>> Installing OBS Studio"
sudo pacman -Sq obs-studio

echo ">>> Installing OBS Studio plugins"
yay -Sq obs-cli obs-ndi obs-v4l2sink obs-linuxbrowser-bin obs-motion-effect-git

echo ">>> Installing Yakuake"
sudo pacman -Sq yakuake

echo "=== Network Drives ==="
echo "======================"

echo ">>> Creating folders"
sudo mkdir /mnt/downloads
sudo mkdir /mnt/hikari
sudo mkdir /mnt/homes
sudo mkdir /mnt/media

echo ">>> Writing Monitor Config"
if ! grep -q 'init-monitors' /etc/X11/xorg.conf.d/dm-multimonitor.sh ; then
    echo '#!/bin/sh' | sudo tee -a /etc/X11/xorg.conf.d/dm-multimonitor.sh
    echo '# init-monitors' | sudo tee -a /etc/X11/xorg.conf.d/dm-multimonitor.sh
    echo 'mon1=DisplayPort-0' | sudo tee -a /etc/X11/xorg.conf.d/dm-multimonitor.sh
    echo 'mon2=DisplayPort-1' | sudo tee -a /etc/X11/xorg.conf.d/dm-multimonitor.sh
    echo 'mon3=DisplayPort-2' | sudo tee -a /etc/X11/xorg.conf.d/dm-multimonitor.sh
    echo '# Uncomment the sleep command, if you face problems, as a possible workaround' | sudo tee -a /etc/X11/xorg.conf.d/dm-multimonitor.sh
    echo '# sleep 3' | sudo tee -a /etc/X11/xorg.conf.d/dm-multimonitor.sh
    echo 'xrandr --output DisplayPort-0 --primary --mode 1920x1080 --pos 1080x420 --rate 239.76 --rotate normal --output DisplayPort-1 --mode 1920x1080 --pos 0x0 --rotate left --output DisplayPort-2 --mode 1920x1080 --pos 3000x0 --rotate right --output HDMI-A-0 --off' | sudo tee -a /etc/X11/xorg.conf.d/dm-multimonitor.sh
fi

echo ">>> Mounting downloads share on Storage 01"
if ! grep -q 'init-downloads' /etc/fstab ; then
    echo '# init-downloads' | sudo tee -a /etc/fstab
    echo '//storage-01.apartment/downloads /mnt/downloads cifs guest,uid=1000,gid=1000,forceuid,forcegid 0 0
' | sudo tee -a /etc/fstab
fi
echo ">>> Mounting hikari share on Storage 01"
if ! grep -q 'init-hikari' /etc/fstab ; then
    echo '# init-hikari' | sudo tee -a /etc/fstab
    echo '//storage-01.apartment/hikari /mnt/hikari cifs guest,uid=1000,gid=1000,forceuid,forcegid 0 0
' | sudo tee -a /etc/fstab
fi
echo ">>> Mounting homes share on Storage 01"
if ! grep -q 'init-homes' /etc/fstab ; then
    echo '# init-homes' | sudo tee -a /etc/fstab
    echo '//storage-01.apartment/homes /mnt/homes cifs username=stony,password=euclid1337,,uid=1000,gid=1000,forceuid,forcegid 0 0
' | sudo tee -a /etc/fstab
fi
echo ">>> Mounting media share on Storage 01"
if ! grep -q 'init-media' /etc/fstab ; then
    echo '# init-media' | sudo tee -a /etc/fstab
    echo '//storage-01.apartment/media /mnt/media cifs guest,uid=1000,gid=1000,forceuid,forcegid 0 0
' | sudo tee -a /etc/fstab
fi


echo "=== Device Fixes ==="
echo "===================="

echo "Fixing UVC bandwidth"
if ! grep -q '# uvc-modules' /etc/modules-load.d/modules.conf ; then
    echo '# uvc-modules' | sudo tee -a /etc/modules-load.d/modules.conf
    echo 'uvcvideo' | sudo tee -a /etc/modules-load.d/modules.conf
    echo 'v4l2loopback' | sudo tee -a /etc/modules-load.d/modules.conf
fi

echo "Fixing UVC bandwidth"
if ! grep -q '# uvc-bandwidth-fix' /etc/modprobe.d/uvcvideo.conf ; then
    echo '# uvc-bandwidth-fix' | sudo tee -a /etc/modprobe.d/uvcvideo.conf
    echo 'options uvcvideo quirks=0x280' | sudo tee -a /etc/modprobe.d/uvcvideo.conf
fi

echo "Fixing ALSA audio glitching"
if ! grep -q '# alsa-glitch-fix' /etc/pulse/default.pa ; then
    echo '# alsa-glitch-fix' | sudo tee -a /etc/pulse/default.pa
    echo 'load-module module-udev-detect tsched=0' | sudo tee -a /etc/pulse/default.pa
fi
