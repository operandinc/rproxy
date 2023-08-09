FROM debian:bookworm-slim

# Install dependencies.
RUN apt-get update && apt-get install -y curl

# # Configure IP forwarding.
# RUN echo 'net.ipv4.ip_forward = 1' | tee -a /etc/sysctl.conf
# RUN echo 'net.ipv6.conf.all.forwarding = 1' | tee -a /etc/sysctl.conf
# RUN sysctl -p /etc/sysctl.conf

# Install Tailscale.
RUN curl -fsSL https://pkgs.tailscale.com/stable/debian/bookworm.noarmor.gpg | tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
RUN curl -fsSL https://pkgs.tailscale.com/stable/debian/bookworm.tailscale-keyring.list | tee /etc/apt/sources.list.d/tailscale.list
RUN apt-get update && apt-get install -y tailscale

# Add the files.
RUN mkdir -p /tstorage
ADD entrypoint.sh /entrypoint.sh

# Get API Key.
ARG TAILSCALE_API_KEY

# Run the entrypoint.
ENTRYPOINT bash /entrypoint.sh