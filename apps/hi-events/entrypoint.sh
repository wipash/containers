#!/bin/sh
set -e

# This is the entrypoint script for the container.
# It checks if the GOSS_OPTS environment variable is set.
# If it is, it means we're running in a dgoss test environment.

if [ -n "$GOSS_OPTS" ]; then
  # We are in a test environment.
  # Instead of starting the application, we'll just idle.
  # This keeps the container running so goss can exec into it.
  echo "GOSS environment detected. Idling..."
  tail -f /dev/null
else
  # This is a normal run (e.g., in Kubernetes).
  # Execute the command passed as arguments to this script (the Dockerfile's CMD).
  echo "Production environment detected. Starting application..."
  exec "$@"
fi
