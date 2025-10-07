#!/bin/bash
export HOST=0.0.0.0
export PORT=${PORT:-7860}
uv run bot.py --host $HOST --port $PORT
