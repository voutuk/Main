#!/bin/bash
set -e

# Create directory for warp configuration if it doesn't exist
sudo mkdir -p /var/lib/cloudflare-warp
sudo chown -R warp:warp /var/lib/cloudflare-warp
sudo mkdir -p /run/cloudflare-warp
sudo chown -R warp:warp /run/cloudflare-warp

# Link the config directory to the standard location
mkdir -p /home/warp/.cloudflare-warp

# Start WARP service
echo "Starting warp-svc..."
sudo /usr/bin/warp-svc &
WARP_SVC_PID=$!

# Sleep for a given time before connecting to allow warp-svc to initialize
echo "Sleeping for ${WARP_SLEEP:-2} seconds to let warp-svc initialize..."
sleep ${WARP_SLEEP:-2}

# Set up the WARP connector with the provided key
if [ -n "$WARP_KEY" ]; then
    echo "Setting up WARP Connector with provided key..."
    # First try to delete existing registration (if any)
    warp-cli --accept-tos registration delete || true
    
    # Set up the new connector registration
    echo "Registering new WARP connector..."
    warp-cli --accept-tos connector new "$WARP_KEY"
    
    # Connect to WARP
    echo "Connecting to WARP..."
    warp-cli --accept-tos connect
    
    # Check the connection status
    echo "WARP connection status:"
    warp-cli --accept-tos status
else
    echo "WARP_KEY environment variable is not set. Cannot set up WARP Connector."
    exit 1
fi

# Start gost proxy
echo "Starting gost proxy with args: ${GOST_ARGS:-"-L :1080"}"
/usr/bin/gost ${GOST_ARGS:-"-L :1080"}

# If gost exits, kill warp-svc
echo "gost proxy exited, killing warp-svc..."
kill $WARP_SVC_PID
wait $WARP_SVC_PID