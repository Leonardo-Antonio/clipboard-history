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
    find /tmp/history/* -type f -name "*history.log" | xargs ls -tr | tail -n 10 | xargs -I {} mv {} /tmp/history/tmp
    find /tmp/history/* -maxdepth 0 -type f -name "*history.log" | xargs rm

    mv /tmp/history/tmp/* /tmp/history/
}


HISTORY_PATH="/tmp/history/"
HISTORY_PATH_TMP="/tmp/history/tmp"
LAST_CLIPBOARD=""

mkdir -p $HISTORY_PATH $HISTORY_PATH_TMP

ITERATIONS=0
while true; do
    CURRENT_CLIPBOARD=$(xclip -o -selection clipboard 2>/dev/null)
    if [[ $ITERATIONS -gt 10 ]]; then
        ITERATIONS=0
        only_x_items
    fi

    if [[ "$CURRENT_CLIPBOARD" != "$LAST_CLIPBOARD" ]]; then
        ITERATIONS=$((ITERATIONS + 1))
        LAST_CLIPBOARD="$CURRENT_CLIPBOARD"
        FILENAME="$ITERATIONS"_clip_history.log
        echo "$CURRENT_CLIPBOARD" > "$HISTORY_PATH$FILENAME"
    fi

    sleep 0.5
done

