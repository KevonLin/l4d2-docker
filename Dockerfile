FROM ubuntu:latest AS base

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

ENV DEFAULT_MAP=$DEFAULT_MAP \
    PORT=27015 \
    GAME_ID=$GAME_ID \
    INSTALL_DIR=$INSTALL_DIR \
    TICKRATE=100

ADD install-plugins.sh .
RUN ./install-plugins.sh

ADD entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]
