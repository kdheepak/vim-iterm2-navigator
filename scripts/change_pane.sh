#!/bin/sh
PROC_NAME=$(osascript -e "
  tell application \"iTerm\"
    activate
    tell the current terminal
      tell the current session
        get name
      end tell
    end tell
end tell")
if [[ "$PROC_NAME" == *"vim"* ]];
then
    echo '\x1b'
    echo ":call iTerm2AwareNavigate(\"$1\")"
    echo '\r'
else
    if $1 == 'h' then
        keycode = '123'
    else if $1 == 'l'
        keycode = 124
    else if $1 == 'j'
        keycode = 125
    else if $1 == 'k'
        keycode = 126
    if
    osascript -e "tell application \"System Events\" to key code $keycode using {command down, option down}"
fi
