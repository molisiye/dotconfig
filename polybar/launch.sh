#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config Location ~/.config/polybar/config
polybar mybar
