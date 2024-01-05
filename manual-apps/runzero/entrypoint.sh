#!/usr/bin/env bash

# Check that both RUMBLE_AGENT_HOST_ID and RUNZERO_URL are set
if [ -z "$RUMBLE_AGENT_HOST_ID" ]; then
  echo "RUMBLE_AGENT_HOST_ID is not set. Exiting."
  exit 1
fi
if [ -z "$RUNZERO_URL" ]; then
  echo "RUNZERO_URL is not set. Exiting."
  exit 1
fi

# Download latest runzero-explorer from URL in ENV variable
curl -o /opt/rumble/runzero-explorer.bin $RUNZERO_URL
chmod +x /opt/rumble/runzero-explorer.bin

exec \
  /opt/rumble/runzero-explorer.bin \
    manual
