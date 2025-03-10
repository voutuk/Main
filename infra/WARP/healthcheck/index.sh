#!/bin/bash

# Check if warp-svc is running
pgrep warp-svc > /dev/null || exit 1

# Check if warp-cli returns a connected status
warp-cli --accept-tos status | grep -q "Connected" || exit 1

# Check if gost proxy is running
pgrep gost > /dev/null || exit 1

# All checks passed
exit 0