#!/bin/bash
set -e

# Find the repository root (where package.json with workspaces is located)
# Start from current directory and walk up until we find package.json with workspaces
REPO_ROOT=$(pwd)
while [ ! -f "$REPO_ROOT/package.json" ] || ! grep -q '"workspaces"' "$REPO_ROOT/package.json" 2>/dev/null; do
  if [ "$REPO_ROOT" = "/" ]; then
    echo "Error: Could not find repository root with workspaces"
    exit 1
  fi
  REPO_ROOT=$(dirname "$REPO_ROOT")
done

echo "Found repo root at: $REPO_ROOT"
cd "$REPO_ROOT"

# Get workspace name from argument
WORKSPACE=$1
if [ -z "$WORKSPACE" ]; then
  echo "Usage: $0 <workspace-name>"
  exit 1
fi

echo "Starting workspace: $WORKSPACE"
npm start --workspace="$WORKSPACE"

