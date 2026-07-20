FROM lacledeslan/steamcmd:linux as cssource-builder

# Copy cached build files (if any)
COPY /build-cache /output

# Download Counter-Strike: Source
RUN /app/steamcmd.sh +force_install_dir /output +login anonymous +app_update 232330 validate +quit;

COPY ./dist/linux/ll-tests /output/ll-tests

#=======================================================================
FROM debian:bookworm-slim

ARG BUILD_NODE=unspecified
ARG GIT_REVISION=unspecified

LABEL architecture="i386" \
    com.lacledeslan.build-node="$BUILD_NODE" \
    maintainer="Laclede's LAN <contact@lacledeslan.com>" \
    org.opencontainers.image.description="Counter-Strike Source Dedicated Server" \
    org.opencontainers.image.revision="$GIT_REVISION" \
    org.opencontainers.image.source="https://github.com/LacledesLAN/gamesvr-cssource" \
    org.opencontainers.image.vendor="Laclede's LAN"

HEALTHCHECK NONE

RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y \
        ca-certificates lib32gcc-s1 libncurses5:i386 libsdl2-2.0-0:i386 libstdc++6 libstdc++6:i386 locales locales-all tmux && \
    apt-get clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*;

ENV LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Set up Environment
RUN useradd --home /app --gid root --system CSSource && \
    mkdir --parents /app && \
    chown CSSource:root -R /app;

COPY --chown=CSSource:root --from=cssource-builder /output /app

RUN chmod +x /app/ll-tests/*.sh && \
    echo $'\n\nLinking steamclient.so to prevent srcds_run errors' && \
        mkdir --parents /app/.steam/sdk32 && \
        ln -s /app/bin/steamclient.so /app/.steam/sdk32/steamclient.so

USER CSSource

WORKDIR /app

CMD ["/bin/bash"]

ONBUILD USER root
