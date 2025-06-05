#!/bin/bash
pkill -f clipboard-history ; ps aux | grep clipboard_history.sh | grep -v grep | awk '{print $2}' | xargs kill -9       