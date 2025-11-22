#!/usr/bin/env bash

NOTIFY_ICON=/usr/share/icons/Papirus/32x32/apps/system-software-update.svg

get_total_updates() { UPDATES=$(~/.config/polybar/scripts/checkupdates 2>/dev/null | wc -l); }

get_total_updates
# notify user of updates
if hash notify-send &>/dev/null; then
    if (( UPDATES > 100 )); then
        notify-send -u critical -i $NOTIFY_ICON \
            "You really need to update!!" "$UPDATES New packages"
    elif (( UPDATES > 40 )); then
        notify-send -u normal -i $NOTIFY_ICON \
            "You should update soon" "$UPDATES New packages"
    elif (( UPDATES > 10 )); then
        notify-send -u low -i $NOTIFY_ICON \
            "$UPDATES New packages"
    fi
fi

# Check twice a minute to see if updated
while (( UPDATES > 0 )); do
    echo " $UPDATES"
    sleep 30
    get_total_updates
done

echo " None"
