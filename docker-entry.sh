#!/bin/bash
for var in DEV_UID DEV_GID; do
    [ -n "${!var}" ] || { echo "\$$var is not set."; exit 1; }
done

if [ $(id -g openwrt) != $DEV_GID ]; then
    groupmod -o -g $DEV_GID openwrt
fi

if [ $(id -u openwrt) != $DEV_UID ]; then
    usermod -o -u $DEV_UID -g $DEV_GID openwrt
fi

chown openwrt:openwrt -R ~openwrt

exec sudo -EHu openwrt "$@"
