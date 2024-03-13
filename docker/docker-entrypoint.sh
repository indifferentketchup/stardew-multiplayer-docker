#!/bin/bash

export HOME=/config

# Start PulseAudio
pulseaudio -D --exit-idle-time=-1

# Create a virtual speaker output
pactl load-module module-null-sink \
    sink_name=SpeakerOutput \
    sink_properties=device.description="dummy"

# Configure mods in parallel
for modPath in $(find /data/Stardew/Stardew\ Valley/Mods/* -maxdepth 0 -type d); do
  mod=$(basename "$modPath")
  var="ENABLE_${mod//[^A-Z]/}_MOD"

  if [ "${!var}" != "true" ]; then
    echo "Removing ${modPath} (${var}=${!var})"
    rm -rf "$modPath" &
  else
    if [ -f "${modPath}/config.json.template" ]; then
      echo "Configuring ${modPath}config.json"
      [ ! -s "${modPath}config.json" ] && envsubst < "${modPath}config.json.template" > "${modPath}config.json" &
    fi
  fi
done
wait

# Run extra steps for certain mods (optimize these scripts if possible)
/opt/configure-remotecontrol-mod.sh
/opt/tail-smapi-log.sh &

# Ready to start!
export DISPLAY=192.168.4.191:0.0
export XAUTHORITY=~/.Xauthority
TERM=

# Modify the StardewValley launcher script using sed
launcher_script="/data/Stardew/Stardew Valley/StardewValley"
sed -i 's|exec env TERM=xterm $LAUNCH_FILE "$@"|exec env SHELL=/bin/bash TERM=xterm $LAUNCH_FILE "$@"|' "$launcher_script"

# Launch Stardew Valley and replace the current process
exec "$launcher_script" "$@"

while true; do
  # Perform any periodic tasks or checks if needed
  sleep 60 # Sleep for 60 seconds before the next iteration
done