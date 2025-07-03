#!/bin/bash
# Notify via Pushover from host when Transmission in Docker finishes download

PUSHOVER_TOKEN='TTTTTTTTTT'
PUSHOVER_USER_KEY='UUUUUUUUUU'

LOG_DIR="/var/log/pushover"
mkdir -p "$LOG_DIR"
LOG_FILE="${LOG_DIR}/transmission_notify-$(date '+%Y-%m-%d_%H-%M-%S').log"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

TORRENT_NAME="$TR_TORRENT_NAME"
TORRENT_DIR="$TR_TORRENT_DIR"

if [[ -z "$TORRENT_NAME" || -z "$TORRENT_DIR" ]]; then
  log "[FATAL] Environment variables not set: TR_TORRENT_NAME or TR_TORRENT_DIR"
  exit 1
fi

MESSAGE="Download Complete: '$TORRENT_NAME'\nSaved in: $TORRENT_DIR\nHost: $(hostname) at $(date '+%Y-%m-%d @ %H:%M:%S')"

RESPONSE=$(curl --silent --show-error --location \
  --form "token=${PUSHOVER_TOKEN}" \
  --form "user=${PUSHOVER_USER_KEY}" \
  --form "message=${MESSAGE}" \
  https://api.pushover.net/1/messages.json 2>&1)

if [[ $? -eq 0 ]]; then
  log "[OK] Sent Pushover message for '$TORRENT_NAME'"
else
  log "[ERROR] Could not send notification"
  log "$RESPONSE"
  exit 1
fi