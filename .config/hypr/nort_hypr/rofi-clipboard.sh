#!/bin/bash

# Run rofi and capture both the output and the exit code
SELECTION=$(cliphist list | rofi -dmenu -kb-accept-custom "" -kb-custom-1 "Control+Return")
EXIT_CODE=$?

# Exit if the user closes rofi without selecting anything
if [ -z "$SELECTION" ]; then
	exit 0
fi

# Decode the selection to the clipboard
echo "$SELECTION" | cliphist decode | wl-copy

# If the user pressed normal Enter (exit code 0), paste the text
if [ "$EXIT_CODE" -eq 0 ]; then
    # Optional short delay to ensure clipboard updates before pasting
    sleep 0.1 
    wtype -M ctrl -k v -m ctrl
elif [ "$EXIT_CODE" -eq 10 ]; then
	# Don't paste immediately
	exit 0
fi
