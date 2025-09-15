#!/bin/bash

# Usage: ./audiovisual.sh "input.mp3" "background.jpg" "output.mp4"

AUDIO="$1"
BG_IMG="$2"
OUTPUT="$3"

if [[ -z "$AUDIO" || -z "$BG_IMG" || -z "$OUTPUT" ]]; then
  echo "Usage: $0 input.mp3 background.jpg output.mp4"
  exit 1
fi

# Derive temp files
WAVEFORM="waveform_temp.mov"

# Get audio duration in seconds
DURATION=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$AUDIO")
DURATION=${DURATION%.*}

# Step 1: Generate transparent waveform video
ffmpeg -y -i "$AUDIO" \
-filter_complex "[0:a]showwaves=s=1280x720:mode=line:rate=25:colors=white|a0" \
-c:v prores_ks -pix_fmt yuva444p10le -profile:v 4 -t "$DURATION" "$WAVEFORM"

# Step 2: Overlay waveform over background
ffmpeg -y -loop 1 -i "$BG_IMG" -i "$WAVEFORM" -i "$AUDIO" \
-filter_complex "[0:v]scale=1280:720[bg]; [1:v]scale=1280:720[wave]; [bg][wave]overlay=format=auto" \
-shortest -c:v libx264 -c:a aac -b:a 192k -pix_fmt yuv420p "$OUTPUT"

# Cleanup
rm -f "$WAVEFORM"

echo "✅ Done! Output saved as: $OUTPUT"

