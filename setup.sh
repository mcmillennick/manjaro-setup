#!/bin/bash
# TODO: https://forum.manjaro.org/t/how-to-replace-pulseaudio-with-jack-jack-and-pulseaudio-together-as-friend/2086
smbusername = 'stony'
smbpassword = 'euclid1337'

echo "=== Packages ==="
echo "================"
echo ">>> Updating packages"
sudo pacman -Syu
yay -Syu

# echo ">>> Setting Up Audio"
# sudo pacman -Sq yay manjaro-pulse pavucontrol

if pacman -Qs vulkan-radeon > /dev/null ; then
  echo ">>> AMDGPU is setup"
else
  echo ">>> AMDGPU is not installed"
  echo ">>> Installing up AMDGPU"
  sudo pacman -Sq lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader
  sudo pacman -Sq lib32-gnutls lib32-libldap lib32-libgpg-error lib32-sqlite lib32-libpulse
  sudo pacman -Sq wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader
fi

if pacman -Qs decklink > /dev/null ; then
  echo "Decklink is installed"
else
  echo "The package $package is not installed"
  echo ">>> Setting up Decklink"
  sudo pacman -Sq dkms
  yay -Sq decklink
fi

if pacman -Qs v4l2loopback-dkms > /dev/null ; then
  echo ">>> v4l2loopback-dkms is installed"
else
  echo ">>> v4l2loopback-dkms is not installed"
  echo ">>> Setting up v4l2loopback"
  yay -Sq v4l2loopback-dkms obs-v4l2sink
fi

if pacman -Qs visual-studio-code-bin > /dev/null ; then
  echo ">>> visual-studio-code-bin is installed"
else
  echo ">>> visual-studio-code-bin is not installed"
  echo ">>> Installing visual-studio-code-bin"
  yay -Sq visual-studio-code-bin 
fi

if pacman -Qs balena-etcher > /dev/null ; then
  echo "balena-etcher is installed"
else
  echo ">>> balena-etcher is not installed"
  echo ">>> installing balena-etcher"
  yay -Sq balena-etcher
fi


if pacman -Qs opera > /dev/null ; then
  echo "opera is installed"
else
  echo ">>> opera is not installed"
  echo ">>> Installing Opera"
  yay -Sq opera
fi

if pacman -Qs rofi > /dev/null ; then
  echo "rofi is installed"
else
  echo ">>> rofi is not installed"
  echo ">>> Installing Rofi"
  yay -Sq rofi
fi


if pacman -Qs discord > /dev/null ; then
    echo "discord is installed"
else
    echo ">>> discord is not installed"
    echo ">>> Installing Discord"
    yay -Sq discord
fi

if pacman -Qs twitch > /dev/null ; then
    echo "twitch is installed"
else
    echo ">>> twitch is not installed"
    echo ">>> Installing Twitch"
    yay -Sq twitch 
fi

if pacman -Qs steam > /dev/null ; then
    echo "steam is installed"
else
    echo ">>> steam is not installed"
    echo ">>> Installing Lutris and Steam"
    sudo pacman -Sq lutris steam
fi

if pacman -Qs freefilesync > /dev/null ; then
    echo "freefilesync is installed"
else
    echo ">>> freefilesync is not installed"
    echo ">>> Installing FreeFileSync"
    yay -Sq freefilesync
fi

if pacman -Qs remmina > /dev/null ; then
    echo "remmina is installed"
else
    echo ">>> remmina is not installed"
    echo ">>> Installing Remmina"
    sudo pacman -Sq freerdp remmina
fi

if pacman -Qs obs-studio > /dev/null ; then
    echo "obs-studio is installed"
else
    echo ">>> obs-studio is not installed"
    echo ">>> Installing OBS Studio"
    sudo pacman -Sq obs-studio
fi

if pacman -Qs obs-motion-effect-git > /dev/null ; then
    echo "obs plugins are installed"
else
    echo ">>> obs plugins are not installed"
    echo ">>> Installing OBS Studio plugins"
    yay -Sq obs-cli obs-ndi obs-v4l2sink obs-linuxbrowser-bin obs-motion-effect-git
fi

if pacman -Qs yakuake > /dev/null ; then
    echo "yakuake is installed"
else
    echo ">>> yakuake is not installed"
    echo ">>> Installing Yakuake"
    sudo pacman -Sq yakuake
fi


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
    sudo chmod +x /etc/X11/xorg.conf.d/dm-multimonitor.sh
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

echo "Fixing UVC modules"
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
