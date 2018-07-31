#!/bin/bash

# Feel free to use and modify this script, but please give credit to
# https://github.com/gaia/tezos-monitoring/

# This script tells you if your baker is running. It doesn't mean the baker is runnning as it should,
# only that the process is running. It could be stuck.

# Enter the name of your tezos user here
tezosuser="tezos"

# Do not modify anything from here down

nodestatus=$(ps -fU $tezosuser | grep "[t]ezos-baker")
echo "$nodestatus" | grep -qi "tezos-baker"
if [ $? -eq 0 ];then
        echo "Baking..."
elif [[ -n "$flag" ]];then
        echo "Baking Stopped"
fi
