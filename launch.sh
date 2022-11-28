#!/bin/bash

# Install bannerlord server through steamcmd
/steamcmd/steamcmd.sh +@sSteamCmdForcePlatformType windows +force_install_dir /bannerlord +login $STEAM_USER $STEAM_PASS +app_update 1863440 validate +quit

# Run the included "Microsoft Visual C++ Redistributable" setup
cd /bannerlord/_CommonRedist/vcredist/2019
wine VC_redist.x64.exe

# Finally, run the server!
cd /bannerlord/bin/Win64_Shipping_Server

wine DedicatedCustomServer.Starter.exe \
    /dedicatedcustomserverconfigfile /bannerlord/configs/ds_config_team_deathmatch.txt \
    /DisableErrorReporting \
    /dedicatedcustomserverauthtoken $AUTH_TOKEN
