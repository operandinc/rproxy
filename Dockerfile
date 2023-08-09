FROM debian:bookworm-slim

# Install Tailscale.
RUN curl -fsSL https://pkgs.tailscale.com/stable/debian/bookworm.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
RUN curl -fsSL https://pkgs.tailscale.com/stable/debian/bookworm.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
RUN sudo apt-get update
RUN sudo apt-get install tailscale

# Tailscaled can't run as root user, cuz of an SO_MARK issue.
# See: https://github.com/tailscale/tailscale/issues/634.
ARG USER=default
ENV HOME /home/$USER
RUN adduser -D $USER \
  && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
  && chmod 0440 /etc/sudoers.d/$USER
USER $USER
WORKDIR $HOME

# Add the files.
RUN mkdir -p $HOME/tstorage
ADD entrypoint.sh $HOME/entrypoint.sh

# Get API Key.
ARG TAILSCALE_API_KEY

# Run the entrypoint.
ENTRYPOINT bash $HOME/entrypoint.sh