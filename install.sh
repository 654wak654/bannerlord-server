#!/bin/bash

# Enable 32 bit architecture (required by wine)
dpkg --add-architecture i386 

# Add wine repository key
mkdir -pm755 /etc/apt/keyrings
wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key

# Add WineHQ sources file:
# TODO: Set debian version variable here
wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/$DEBIAN_VERSION/winehq-$DEBIAN_VERSION.sources

# Install stable wine
apt update && apt install --install-recommends winehq-stable
