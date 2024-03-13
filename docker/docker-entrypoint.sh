#!/bin/bash

export HOME=/config

# Start PulseAudio
pulseaudio -D --exit-idle-time=-1

# Create a virtual speaker output
pactl load-module module-null-sink \
    sink_name=SpeakerOutput \
    sink_properties=device.description="dummy"

# Configure mods
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

# Run extra steps for certain mods (optimize these scripts if possible)
/opt/configure-remotecontrol-mod.sh
/opt/tail-smapi-log.sh &

# Ready to start!
export XAUTHORITY=~/.Xauthority
TERM=

# Set OpenGL environment variables
export LIBGL_ALWAYS_INDIRECT=1
export MESA_GL_VERSION_OVERRIDE=4.1
export MESA_GLSL_VERSION_OVERRIDE=410

# Modify the StardewValley launcher script using sed
launcher_script="/data/Stardew/Stardew Valley/StardewValley"
sed -i 's|exec env TERM=xterm $LAUNCH_FILE "$@"|exec env SHELL=/bin/bash TERM=xterm $LAUNCH_FILE "$@"|' "$launcher_script"

# Launch Stardew Valley and replace the current process
exec "$launcher_script" "$@"

while true; do
  # Perform any periodic tasks or checks if needed
  sleep 60 # Sleep for 60 seconds before the next iteration
done