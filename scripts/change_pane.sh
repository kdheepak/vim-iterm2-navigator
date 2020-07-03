#!/bin/bash
PROCNAME=$(osascript -e "
    tell application \"iTerm2\"
        activate
        tell current window
            tell the current session
                get name
            end tell
        end tell
    end tell
")
if [[ "$PROC_NAME" == *"vim"* ]];
then
    echo '\x1b'
    echo ":call VimiTerm2AwareNavigate(\"$1\")"
    echo '\r'
else
    if [[ "$1" == "h" ]]; then
        keycode='123'
    elif [[ "$1" == "l" ]]; then
        keycode=124
    elif [[ "$1" == "j" ]]; then
        keycode=125
    elif [[ "$1" == "k" ]]; then
        keycode=126
    fi
    osascript -e "tell application \"System Events\" to key code $keycode using {command down, option down}"
fi
