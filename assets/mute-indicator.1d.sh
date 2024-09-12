#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SCRIPT_NAME=$(basename "$0")
ASSETS_DIR="${SCRIPT_DIR}/mute-indicator/assets"

icon_unmuted=$(base64 -i "${ASSETS_DIR}/microphone.png")
icon_muted=$(base64 -i "${ASSETS_DIR}/microphone-muted.png")

current_volume=$(osascript -e "input volume of (get volume settings)")

if [ $# -eq 0 ]; then
    if (( $current_volume <= 1 )); then
        echo " | templateImage=${icon_muted}"
        echo "---"
        echo "Unmute | bash='${SCRIPT_DIR}/${SCRIPT_NAME}' param1=toggle terminal=false"
    else
        echo " | templateImage=${icon_unmuted}"
        echo "---"
        echo "Mute | bash='${SCRIPT_DIR}/${SCRIPT_NAME}' param1=toggle terminal=false"
    fi
else
    if [ "$1" == "toggle" ]; then
        osascript "${SCRIPT_DIR}/mute-indicator/assets/toggle_mic.scpt" && open xbar://app.xbarapp.com/refreshPlugin?path=${SCRIPT_NAME}
    fi
fi
