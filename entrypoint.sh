#!/bin/bash

echo "Starting tailscale proxy..."
tailscaled --state=/tstorage/tailscale.state \
    --socket=/tstorage/tailscale.sock &
until tailscale --socket=/tstorage/tailscale.sock \
    up \
    --advertise-exit-node \
    --authkey=$TAILSCALE_AUTHKEY
do
    echo "Waiting for auth..."
    sleep 5
done
echo "Tailscale proxy started."

# Sleep indefinitely
for (( ; ; ))
do
    sleep 500
done