# escape=`

FROM lacledeslan/steamcmd:linux as cssource-builder

#=======================================================================
FROM i386/debian:stretch-slim

HEALTHCHECK NONE

ARG BUILDNODE="unspecified"
ARG SOURCE_COMMIT

LABEL maintainer="Laclede's LAN <contact@lacledeslan.com>" `
      com.lacledeslan.build-node=$BUILDNODE `
      org.label-schema.schema-version="1.0" `
      org.label-schema.url="https://github.com/LacledesLAN/README.1ST" `
      org.label-schema.vcs-ref=$SOURCE_COMMIT `
      org.label-schema.vendor="Laclede's LAN" `
      org.label-schema.description="Counter-Strike Source in Docker" `
      org.label-schema.vcs-url="https://github.com/LacledesLAN/gamesvr-cssource"

RUN apt-get update && apt-get install -y `
        libcurl3-gnutls libstdc++6 libncurses5 libz1 &&`
    apt-get clean &&`
    rm -rf /var/lib/apt/lists/*;

## CSSource is so large we can't reliably use multi-stage builds in docker cloud

# Copy files in from builder (if any)
COPY --from=cssource-builder /output /app

# Copy cached build files (if any)
COPY ./build-cache /app

#Pull in SteamCMD
COPY --from=cssource-builder /app /app/steamcmd

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

## Add in tests
COPY ./tests /app/ll-tests

RUN echo $'\n\nCreating user "CSSource" (to group "root" until [github.com/moby/moby/pull/34263] makes it into CE stable)' &&`
        useradd --home /app --gid root --system `
            CSSource &&`
    echo 'Setting user directory permissions' &&`
        chown CSSource:root /app &&`
        find /app -type d -exec chmod 775 {} + &&`
        chmod +x /app/ll-tests/*.sh

# Intentionally set after all build steps
USER CSSource

WORKDIR /app

ONBUILD USER root
