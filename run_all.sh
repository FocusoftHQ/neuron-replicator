#!/bin/bash

# Exit on error
set -e

CONFIG_FILE="config.json"
REPLICATOR_SCRIPT="./scripts/replicator.sh"

if [ ! -f "$CONFIG_FILE" ]; then
  echo "❌ config.json not found!"
  exit 1
fi

if [ ! -f "$REPLICATOR_SCRIPT" ]; then
  echo "❌ replicator.sh not found in ./scripts/"
  exit 1
fi

# Read each pair from config.json using jq
REPO_PAIRS=$(jq -c '.[]' "$CONFIG_FILE")

if [ -z "$REPO_PAIRS" ]; then
  echo "⚠️ No repo pairs found in config.json"
  exit 0
fi

for pair in $REPO_PAIRS; do
  SOURCE=$(echo "$pair" | jq -r '.source')
  DESTINATION=$(echo "$pair" | jq -r '.destination')

  echo "➡️ Syncing: $SOURCE → $DESTINATION"
  bash "$REPLICATOR_SCRIPT" -s "$SOURCE" -d "$DESTINATION"
  echo ""
done

echo "✅ All repo pairs processed."
