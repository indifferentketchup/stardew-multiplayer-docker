# Pull base image.
FROM jlesage/baseimage-gui:debian-11-v4.5.3

# Set the name of the application.
ENV APP_NAME="StardewValley"

RUN apt-get update
RUN apt-get install -y --no-install-recommends wget unzip tar strace mono-complete xterm gettext-base jq netcat procps pulseaudio build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
    libxinerama1 \
    xserver-xorg-video-intel xserver-xorg-core xserver-xorg-video-dummy \
    x11proto-damage-dev x11-utils  x11-xserver-utils \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    mesa-utils \
    fonts-dejavu-core \
    libc6 libgcc-s1 \
    tigervnc-standalone-server \
    && rm -rf /var/lib/apt/lists/*

# Install locales package
RUN apt-get update && apt-get install -y locales

# Generate and set the desired locale (e.g., en_US.UTF-8)
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

RUN APP_ICON_URL=https://i.ibb.co/tJJjxsF/fern.png && \
    install_app_icon.sh "$APP_ICON_URL"

# Game + ModLoader 1.5.6 3.18.2
RUN mkdir -p /data/Stardew && \
    mkdir -p /data/nexus && \
    wget https://eris.cc/Stardew_latest.tar.gz -qO /data/latest.tar.gz && \
    tar xf /data/latest.tar.gz -C /data/Stardew && \
    rm /data/latest.tar.gz 

RUN wget -qO dotnet.tar.gz https://download.visualstudio.microsoft.com/download/pr/85bcc525-4e9c-471e-9c1d-96259aa1a315/930833ef34f66fe9ee2643b0ba21621a/dotnet-sdk-8.0.201-linux-x64.tar.gz \
#RUN wget -qO dotnet.tar.gz https://download.visualstudio.microsoft.com/download/pr/e57d7fe5-06c8-44ad-861b-e6b598adf5d3/d682ed25fe5bd0cedd8676d95603072d/dotnet-runtime-8.0.2-linux-musl-x64.tar.gz \
    && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet 

RUN wget https://github.com/Pathoschild/SMAPI/releases/download/3.18.6/SMAPI-3.18.6-installer.zip -qO /data/nexus.zip && \
    unzip /data/nexus.zip -d /data/nexus/ && \
    /bin/bash -c "SMAPI_NO_TERMINAL=true SMAPI_USE_CURRENT_SHELL=true echo -e \"2\n\n\" | /data/nexus/SMAPI\ 3.18.6\ installer/internal/linux/SMAPI.Installer --install --game-path \"/data/Stardew/Stardew Valley\"" || :

# Add Mods & Scripts
COPY ["mods/", "/data/Stardew/Stardew Valley/Mods/"]
COPY scripts/ /opt/

RUN chmod +x /data/Stardew/Stardew\ Valley/StardewValley && \
    chmod -R 777 /data/Stardew/ && \
    chown -R 1000:1000 /data/Stardew && \
    chmod +x /opt/*.sh

RUN mkdir /etc/services.d/utils && touch /etc/services.d/app/utils.dep
COPY run /etc/services.d/utils/run 
RUN chmod +x /etc/services.d/utils/run 

# Copy custom xorg.conf file
COPY xorg.conf /etc/X11/xorg.conf

COPY docker-entrypoint.sh /startapp.sh

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*