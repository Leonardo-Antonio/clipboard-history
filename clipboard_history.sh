#!/bin/bash

function clear_files_tmp() {
    rm -rf /tmp/history/*
}

function ctrl_c() {
    clear_files_tmp
    exit 1
}

trap clear_files_tmp EXIT    
trap ctrl_c SIGINT
trap clear_files_tmp SIGTERM

function only_x_items() {
    files=($(find /tmp/history/ -maxdepth 1 -type f -name "*history.log" -printf "%T@ %p\n" | sort -n | awk '{print $2}'))
    count=${#files[@]}
    if [ "$count" -gt 10 ]; then
        REMOVE_FILES_COUNT=$((count - 10))
        for ((i=0; i<REMOVE_FILES_COUNT; i++)); do
            rm -f "${files[$i]}"
        done
    fi
}



HISTORY_PATH="/tmp/history/"
HISTORY_PATH_TMP="/tmp/history/tmp"
LAST_CLIPBOARD=""

mkdir -p $HISTORY_PATH $HISTORY_PATH_TMP

ITERATIONS=0
COUNTER=0
while true; do
    CURRENT_CLIPBOARD=$(xclip -o -selection clipboard 2>/dev/null)

    if [[ "$CURRENT_CLIPBOARD" != "$LAST_CLIPBOARD" ]]; then
        ITERATIONS=$((ITERATIONS + 1))
        COUNTER=$((COUNTER + 1))
        LAST_CLIPBOARD="$CURRENT_CLIPBOARD"
        FILENAME="$ITERATIONS"_clip_history.log
        echo "$CURRENT_CLIPBOARD" > "$HISTORY_PATH$FILENAME"
    fi

    echo "$COUNTER"
    if [[ $COUNTER -gt 10 ]]; then
        echo "entro en el if"
        COUNTER=$((COUNTER - 1))
        only_x_items
    fi

    sleep 0.5
done

