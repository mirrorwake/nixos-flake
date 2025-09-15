#!/bin/bash

trap 'echo -e "\nExiting scanner...\nLast command copied to clipboard."; wl-copy "picocom -b $BAUD $PORT"; exit 1' SIGINT

PORT="/dev/ttyUSB0"
RATES=(115200 57600 38400 19200 9600 4800 2400 1200)

for BAUD in "${RATES[@]}"; do
  trap "echo -e '\nExiting...\nLast tried: $BAUD'; wl-copy \"picocom -b $BAUD $PORT\"; exit 1" SIGINT
  echo "Trying baud rate: $BAUD"
  picocom -b "$BAUD" "$PORT"
  echo "Press Enter to try next rate"
  read
done
