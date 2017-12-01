# escape=`
FROM lacledeslan/steamcmd:linux as cssource-builder

#=======================================================================
FROM debian:stable-slim

ARG BUILDNODE=unspecified
ARG SOURCE_COMMIT=unspecified

HEALTHCHECK NONE

RUN dpkg --add-architecture i386 &&`
    apt-get update && apt-get install -y `
        ca-certificates lib32gcc1 lib32tinfo5 libcurl4-gnutls-dev:i386 libstdc++6 libstdc++6:i386 libtcmalloc-minimal4:i386 procps screen &&`
    apt-get clean &&`
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*;

LABEL maintainer="Laclede's LAN <contact@lacledeslan.com>" `
      com.lacledeslan.build-node=$BUILDNODE `
      org.label-schema.schema-version="1.0" `
      org.label-schema.url="https://github.com/LacledesLAN/README.1ST" `
      org.label-schema.vcs-ref=$SOURCE_COMMIT `
      org.label-schema.vendor="Laclede's LAN" `
      org.label-schema.description="Counter-Strike Source Dedicated Server" `
      org.label-schema.vcs-url="https://github.com/LacledesLAN/gamesvr-cssource"

# Set up Enviornment
RUN useradd --home /app --gid root --system CSSource &&`
    mkdir -p /app/ll-tests &&`
    chown CSSource:root -R /app;

## CSSource is so large we can't reliably use multi-stage builds in docker cloud

# Copy cached build files (if any)
COPY ./build-cache /app

#Pull in SteamCMD
COPY --from=cssource-builder /app /app/steamcmd

## Add in tests
COPY ./ll-tests /app/ll-tests

# Copy files in from builder (if any)
COPY --from=cssource-builder /output /app
# Ownership shim until [github.com/moby/moby/pull/34263] makes it into Docker Cloud
RUN chown -R CSSource:root /app;

RUN chmod +rx /app/ll-tests/*.sh &&`
    chmod +rwx /app/ll-tests &&`
    chown CSSource:root -R /app/ll-tests;

USER CSSource

# Install Counter-Strike: Source
RUN echo $'\n\nDownloading Counter-Strike: Source via SteamCMD' &&`
        /app/steamcmd/steamcmd.sh `
            +login anonymous `
            +force_install_dir /app `
            +app_update 232330  validate `
            +quit;

RUN echo $'\n\nLinking steamclient.so to prevent srcds_run errors' &&`
        mkdir --parents /app/.steam/sdk32 &&`
        ln -s /app/bin/steamclient.so /app/.steam/sdk32/steamclient.so

WORKDIR /app

ONBUILD USER root
