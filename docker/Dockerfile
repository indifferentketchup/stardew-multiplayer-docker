# Pull base image.
FROM jlesage/baseimage-gui:debian-11-v4.5.3

# Set the name of the application.
ENV APP_NAME="StardewValley"

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget unzip tar strace mono-complete xterm gettext-base jq netcat procps pulseaudio \
    && rm -rf /var/lib/apt/lists/*

RUN APP_ICON_URL=https://i.ibb.co/tJJjxsF/fern.png && \
    install_app_icon.sh "$APP_ICON_URL"

# Game + ModLoader 1.5.6 3.18.2
RUN mkdir -p /data/Stardew /data/nexus && \
    wget https://eris.cc/Stardew_latest.tar.gz -qO /data/latest.tar.gz && \
    tar xf /data/latest.tar.gz -C /data/Stardew && \
    rm /data/latest.tar.gz

RUN wget -qO dotnet.tar.gz https://download.visualstudio.microsoft.com/download/pr/6788a5a5-1879-4095-948d-72c7fbdf350f/c996151548ec9f24d553817db64c3577/dotnet-sdk-5.0.402-linux-x64.tar.gz && \
    tar -zxf dotnet.tar.gz -C /usr/share/dotnet && \
    rm dotnet.tar.gz && \
    ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

RUN wget https://github.com/Pathoschild/SMAPI/releases/download/3.18.6/SMAPI-3.18.6-installer.zip -qO /data/nexus.zip && \
    unzip /data/nexus.zip -d /data/nexus/ && \
    /bin/bash -c "SMAPI_NO_TERMINAL=true SMAPI_USE_CURRENT_SHELL=true echo -e \"2\n\n\" | /data/nexus/SMAPI\ 3.18.6\ installer/internal/linux/SMAPI.Installer --install --game-path \"/data/Stardew/Stardew Valley\"" || :

# Add Mods & Scripts
COPY ["mods/", "/data/Stardew/Stardew Valley/Mods/"]
COPY scripts/ /opt/

RUN chmod +x "/data/Stardew/Stardew Valley/StardewValley" && \
    chmod -R 777 /data/Stardew/ && \
    chown -R 1000:1000 /data/Stardew && \
    chmod +x /opt/*.sh

# TigerVNC Security and Configuration
COPY ["TigerVNC/Security/", "/etc/tigervnc/security/"]
COPY ["TigerVNC/Config/", "/etc/tigervnc/config/"]

RUN mkdir /etc/services.d/utils && touch /etc/services.d/app/utils.dep
COPY run /etc/services.d/utils/run 
RUN chmod +x /etc/services.d/utils/run 

COPY docker-entrypoint.sh /startapp.sh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*