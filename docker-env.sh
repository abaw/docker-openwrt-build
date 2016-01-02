# Set OPENWRT_DIR and then source this file to get a command "d" for easily invoking "docker run"

if [ -z "$BASH_SOURCE" ]; then
    echo "This only works for bash" >&2
else
    [ "$BASH_SOURCE" != "$0" ] || { echo "This file must be sourced" >&2; exit 1;}
    [ -d "$OPENWRT_DIR" ] || { echo "$OPENWRT_DIR is not a directory!"; return 1; }
    export DOCKER_ENV_OPENWRT_DIR=$(readlink -f "$OPENWRT_DIR")
    function d ()
    {
        local CURDIR=$(readlink -f $PWD)
        [[ "$CURDIR" == ${DOCKER_ENV_OPENWRT_DIR}* ]] || { echo "Current directory \"$CURDIR\" is not under directory \"$DOCKER_ENV_OPENWRT_DIR\""; return 1; }
        docker run -it --rm -e DEV_UID=$(id -u) -e DEV_GID=$(id -g) -v $DOCKER_ENV_OPENWRT_DIR:$DOCKER_ENV_OPENWRT_DIR -w $CURDIR openwrt-build "$@"
    }
fi

