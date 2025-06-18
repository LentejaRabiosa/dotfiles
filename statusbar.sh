#!/bin/sh

while true; do
    ram="$(free | awk '/Mem:/ { printf "%.0f", $3/$2 * 100 }')"
    cpu="$(top -bn1 | awk '/^%Cpu/ { printf "%.0f", $2 }')"
    temp="$(cat /sys/class/thermal/thermal_zone0/temp | awk '{ printf "%.0f", $1 / 1000 }')"
    mem="$(df / | awk 'NR==2 { used=$3; total=$2; printf "%.0f", used/total * 100 }')"
    bri="$(brightnessctl -m | awk -F, '{ gsub("%","",$4); printf "%s", $4 }')"
    datetime="$(date '+%a %b %d %H:%M')"

    xsetroot -name " RAM ${ram}%   CPU ${cpu}%   TEM ${temp}ºC   STO ${mem}%   BRI ${bri}%   ${datetime} "
    sleep 1
done

# while true; do
#     mem="$(free -m | awk '/^Mem:/ { printf "%d/%d MiB", $3, $2 }')"
#     disk="$(df -h / | awk 'NR==2 { printf "%s/%s", $3, $2 }')"
#     bright="$(brightnessctl -m | awk -F, '{ gsub("%","",$4); printf "%s%%", $4 }')"
#     datetime="$(date '+%a %b %d %H:%M')"
#
#     xsetroot -name " $mem mem - $disk disk - $bright bright - $datetime "
#     sleep 1
# done

