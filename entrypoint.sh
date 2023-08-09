#!/bin/bash

echo "Starting tailscale proxy..."
tailscaled --state=$HOME/tstorage/tailscale.state \
    --tun=userspace-networking \
    --socket=$HOME/tstorage/tailscale.sock &
until tailscale --socket=$HOME/tstorage/tailscale.sock \
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