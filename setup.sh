#!/usr/bin/sh
background="$1"
if [ -n "$background" ];
then
    echo "$background"
    /usr/bin/feh --bg-fill "$background"
fi
xinput set-prop "MSFT0002:00 04F3:31BE Mouse" "libinput Natural Scrolling Enabled" 0
xinput set-prop "MSFT0002:00 04F3:31BE Touchpad" "libinput Tapping Enabled" 1
xinput set-prop "MSFT0002:00 04F3:31BE Touchpad" "libinput Natural Scrolling Enabled" 1
xinput set-prop "MSFT0002:00 04F3:31BE Touchpad" "libinput Accel Speed" .4
xrdb -load ~/programming/dotfiles/Xresources.main
setxkbmap -option ctrl:nocaps
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Control_L"
xmodmap -e "add Lock = Caps_Lock"
picom -b
