# !/bin/bash

source .venv/bin/activate
AUTO_EXEC_PASTE=1 python3 main.py &
source clipboard_history.sh