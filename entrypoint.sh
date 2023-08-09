#!/bin/bash

echo "Starting tailscale proxy..."
tailscaled --state=/tstorage/tailscale.state \
    --tun=userspace-networking \
    --socket=/tstorage/tailscale.sock &
until tailscale --socket=/tstorage/tailscale.sock \
    up \
    --advertise-routes=fd12::/16 \
    --authkey=$TAILSCALE_API_KEY
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