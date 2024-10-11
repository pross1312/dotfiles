#!/bin/sh

# Authors:
# - Moritz Warning <moritzwarning@web.de> (2016)
# - Zhong Jianxin <azuwis@gmail.com> (2014)
# - Akhil Jalagam <contact@akhil.io> (2019)
# See file LICENSE at the project root directory for license information.
# i3status -c ~/.config/i3/status.conf |
#     (read line && echo "$line" && read line && echo "$line" && read line && echo "$line" && update_rate && while :
# do
#     brightness=$(brightnessctl get)
#     read line
#     echo ",[{\"full_text\":\"${rate} | Sun: $(($brightness/75))% \" },${line#,\[}" || exit 1
# done)

i3status -c ~/.config/i3/status.conf |
    (read line && echo "$line" && read line && echo "$line" && read line && echo "$line" && while :
do
    brightness=$(brightnessctl get)
    read line
    echo ",[{\"full_text\":\"Sun: $(python3 -c "print(round($brightness/2.55))")% \" },${line#,\[}" || exit 1
done)
