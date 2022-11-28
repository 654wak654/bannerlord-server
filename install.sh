#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# Enable 32 bit architecture (required by wine and steam)
dpkg --add-architecture i386

# Install utilities and requirements
apt update && apt install cabextract lib32gcc-s1 lib32stdc++6 libcurl4 lsb-release unzip wget xvfb -y

# Add wine repository key
mkdir -pm755 /etc/apt/keyrings
wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key

# Add WineHQ sources file
export VERSION_CODENAME=$(lsb_release -cs)
wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/$VERSION_CODENAME/winehq-$VERSION_CODENAME.sources

# Install stable wine
apt update && apt install --install-recommends winehq-stable -y

# Get winetricks script
wget 'https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks' -O /usr/local/bin/winetricks
chmod +x /usr/local/bin/winetricks

# Create a wine prefix for dotnet
# This command has tons of errors and can't actually finish, buuut leaving it running for 20 seconds lets it create the directories we need, so it's good enough
# 5 seconds is plenty, but I'm accounting for slow VMs, mechanical HDDs etc
timeout -s KILL 20s xvfb-run wineboot --init

# We need to wait a bit between the wine prefix creation and the actual install, otherwise winetricks gets stuck
sleep 5

# Install dotnet 4.7.1 with winetricks
xvfb-run winetricks --unattended --force dotnet471 corefonts

# Install steamcmd
mkdir -p /steamcmd
wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf - -C /steamcmd
