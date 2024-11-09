FROM rockylinux/rockylinux:9-minimal AS base

ADD as-root.sh .
RUN ./as-root.sh

WORKDIR /home/louis
USER louis

FROM base AS game

ARG GAME_ID=222860
ARG INSTALL_DIR="l4d2"
ARG DEFAULT_MAP="c2m1_highway"

EXPOSE 27015/tcp 27015/udp

ADD as-user.sh .
RUN ./as-user.sh

VOLUME ["/data"]

ENV DEFAULT_MAP=$DEFAULT_MAP \
    DEFAULT_MODE="coop" \
    PORT=0 \
    HOSTNAME="My Cool Server" \
    REGION=255 \
    GAME_ID=$GAME_ID \
    INSTALL_DIR=$INSTALL_DIR \
    STEAM_GROUP=0

ADD tickrate_enabler.dll /$INSTALL_DIR/left4dead2/addons/tickrate_enabler.dll
ADD tickrate_enabler.so /$INSTALL_DIR/left4dead2/addons/tickrate_enabler.so
ADD tickrate_enabler.vdf /$INSTALL_DIR/left4dead2/addons/tickrate_enabler.vdf

ADD entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]
