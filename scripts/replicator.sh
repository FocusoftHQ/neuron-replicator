#!/bin/bash

# Exit on error
set -e

while getopts "s:d:" opt; do
  case $opt in
    s) SOURCE_REPO="$OPTARG" ;;
    d) DESTINATION_REPO="$OPTARG" ;;
    *) echo "Invalid option"; exit 1 ;;
  esac
done

if [ -z "$SOURCE_REPO" ] || [ -z "$DESTINATION_REPO" ]; then
  echo "❌ Usage: ./replicator.sh -s <SOURCE_REPO> -d <DESTINATION_REPO>"
  exit 1
fi

# Set repo URLs (Use HTTPS or SSH depending on your setup)
echo "source: $SOURCE_REPO"
echo "destination: $DESTINATION_REPO"

# Ask for confirmation
read -p "Do you want to continue? (press y/yes to proceed, or n/no to abort): " confirm

# Convert input to uppercase
confirm_upper=$(echo "$confirm" | tr '[:lower:]' '[:upper:]')

# Check user input
if [[ "$confirm_upper" == "Y" || "$confirm_upper" == "YES" ]]; then
  echo "Continuing..."
else
  echo "Aborted."
  exit 1
fi

echo "User confirmed. Continuing..."

# Temp directory to work in
WORKDIR="repo_sync_workspace"

# Clean up if folder already exists
if [ -d "$WORKDIR" ]; then
    echo "Cleaning up existing $WORKDIR folder..."
    rm -rf "$WORKDIR"
fi

mkdir "$WORKDIR"
cd "$WORKDIR"
echo "Working in $WORKDIR"

# Clone source repo
echo "Cloning source repo..."
git clone "$SOURCE_REPO" source
cd source

# Pull latest from main
echo "Pulling latest from main branch..."
git checkout main
git pull origin main

# Change remote to destination
echo "Changing remote to destination repo..."
git remote remove origin
git remote add destination "$DESTINATION_REPO"

# Push to destination main branch
echo "Pushing to destination repo..."
git push --force destination main

# Clean up
cd ..
cd ..
rm -rf "$WORKDIR"
echo "✅ Sync complete."
