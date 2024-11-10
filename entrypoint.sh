#!/bin/bash
# Auto update flag not working on L4D
if [ "${INSTALL_DIR}" = "l4d" ]; then
    ./steamcmd.sh +runscript update.txt
fi

cd "${INSTALL_DIR}" || exit 50

if [ $# -gt 0 ]; then
    ./srcds_run "$@"
else
    STARTUP=("./srcds_run")

    if [ "${INSTALL_DIR}" = "l4d2" ]; then
        STARTUP+=("-autoupdate -steam_dir $HOME -steamcmd_script $HOME/update.txt")
    fi
    
    STARTUP+=("-game left4dead2 -ip $IP -port $PORT -tickrate $TICKRATE +map $DEFAULT_MAP +exec server.cfg")

    ${STARTUP[*]}
fi