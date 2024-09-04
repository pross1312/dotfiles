#! /usr/bin/sh
background_img=~/background/img.jpg
xinput set-prop "MSFT0002:00 04F3:31BE Mouse" "libinput Natural Scrolling Enabled" 0
xinput set-prop "MSFT0002:00 04F3:31BE Touchpad" "libinput Tapping Enabled" 1
xinput set-prop "MSFT0002:00 04F3:31BE Touchpad" "libinput Natural Scrolling Enabled" 1
xinput set-prop "MSFT0002:00 04F3:31BE Touchpad" "libinput Accel Speed" .4
/usr/bin/feh --bg-scale $background_img
xrdb -load ~/dotfiles/Xresources.main
setxkbmap -option ctrl:nocaps
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Control_L"
xmodmap -e "add Lock = Caps_Lock"
picom -b

if command -v fcitx5 > /dev/null && command -v fcitx5-remote > /dev/null
then
    if ! fcitx5-remote > /dev/null
    then
        eval 'fcitx5 -d > /dev/null'
    fi
fi
