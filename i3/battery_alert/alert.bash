#!/bin/bash
bat_files="/sys/class/power_supply/BAT1"
bat_status=$(cat ${bat_files}/status)
capacity=$(cat "${bat_files}/capacity")

if [[ $bat_status == "Discharging" && ${capacity} -le 30 ]]; then
    check_mute=`pactl get-sink-mute @DEFAULT_SINK@`
    volume_raw=`pactl get-sink-volume @DEFAULT_SINK@`
    [[ $volume_raw =~ ([0-9]*%) ]] && left_volume=${BASH_REMATCH[0]}; right_volume=${BASH_REMATCH[1]}
    if [[ $check_mute == 'Mute: yes' ]]; then
        pactl set-sink-mute @DEFAULT_SINK@ no
    fi
    # echo "Battery alert - ${capacity}%"
    pactl set-sink-volume @DEFAULT_SINK@ 100% # temporary increase volume
    paplay --volume=65536 /usr/share/sounds/freedesktop/stereo/message-new-instant.oga
    notify-send \
            --urgency=critical \
            --icon=/usr/share/icons/HighContrast/32x32/status/battery-low.png \
            "Low battery" \
            "Only ${capacity}% battery remaining"
    # zenity --warning \
    #        --window-icon=/usr/share/icons/HighContrast/32x32/status/battery-low.png \
    #        --text="Only ${capacity}% battery remaining"
    if [[ $check_mute == 'Mute: yes' ]]; then
        pactl set-sink-mute @DEFAULT_SINK@ yes
    fi
    pactl set-sink-volume @DEFAULT_SINK@ $left_volume # set back
fi
