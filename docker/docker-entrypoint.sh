#!/bin/bash
export HOME=/config

# start pulseaudio
pulseaudio -D --exit-idle-time=-1

# create a virtual speaker output, otherwise SpaceCore will crash when trying
# to find output device, and Stardew Valley Expanded will not load
pactl load-module module-null-sink \
    sink_name=SpeakerOutput \
    sink_properties=device.description="dummy"
    
for modPath in /data/Stardew/Stardew\ Valley/Mods/*/
do
  mod=$(basename "$modPath")

  # Normalize mod name ot uppercase and only characters, eg. "Always On Server" => ENABLE_ALWAYSONSERVER_MOD
  var="ENABLE_$(echo "${mod^^}" | tr -cd '[A-Z]')_MOD"

  # Remove the mod if it's not enabled
  if [ "${!var}" != "true" ]; then
    echo "Removing ${modPath} (${var}=${!var})"
    rm -rf "$modPath"
    continue
  fi

  if [ -f "${modPath}/config.json.template" ]; then
    echo "Configuring ${modPath}config.json"

    # Seed the config.json only if one isn't manually mounted in (or is empty)
    if [ "$(cat "${modPath}config.json" 2> /dev/null)" == "" ]; then
      envsubst < "${modPath}config.json.template" > "${modPath}config.json"
    fi
  fi
done

# Run extra steps for certain mods
/opt/configure-remotecontrol-mod.sh

/opt/tail-smapi-log.sh &

# Ready to start!

export DISPLAY=192.168.4.191:0.0

export XAUTHORITY=~/.Xauthority
TERM=
sed -i -e 's/env TERM=xterm $LAUNCHER "$@"$/env SHELL=\/bin\/bash TERM=xterm xterm  -e "\/bin\/bash -c $LAUNCHER "$@""/' /data/Stardew/Stardew\ Valley/StardewValley

bash -c "/data/Stardew/Stardew\ Valley/StardewValley"

sleep 233333333333333
