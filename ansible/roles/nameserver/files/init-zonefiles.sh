#!/bin/bash

init_zonefiles=$(find /etc/bind/init-zonefiles -type f -name "*.zone")

if [[ -n $init_zonefiles ]]
then
    for file in $init_zonefiles
    do
        dstpath=/var/lib/bind/$(basename "$file")

        if [[ ! -f $dstpath ]]
        then
            cp "$file" "$dstpath"
            chown bind:bind "$dstpath"
            chmod 644 "$dstpath"
        fi
    done
fi
