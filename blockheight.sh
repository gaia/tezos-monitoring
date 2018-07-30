#!/bin/bash

# Feel free to use and modify this script, but please give credit to
# https://github.com/gaia/tezos-monitoring/

# You need to install JQ: https://stedolan.github.io/jq/
# For cleaner output use this in your command line
# export TEZOS_CLIENT_UNSAFE_DISABLE_DISCLAIMER=Y

# Options
# Use "headers" to print out what each column means
# Use "status" to get a simple node is behind or up to date output, without numbers.
# This is useful when you only want to be alerted if your node falls behind by 10 or more block.
# Anything less than 10 blocks could be a false alarm

# This script will print nothing if the node isn't running

# Enter your path to tezos-client here, without a trailing slash
tc="/home/tezos/tezos/tezos-client"

# Do not modify anything from here down

flag=$1
nodestatus=$(ps -fU tezos | grep "[t]ezos-node run")
echo "$nodestatus" | grep -qi "tezos-node run"
if [ $? -eq 0 ];then
        if [[ $flag = "headers" ]];then
                echo -e "DATE      |TIME    |NETWORK|NODE   |BEHIND"
        fi
        network=$(curl -s "http://api6.tzscan.io/v2/blocks?number=1" | jq '.[] | .level')
        hash=$($tc rpc get /chains/main/blocks?length=1 | tail -n 1 | cut -d \" -f2)
        node=$($tc rpc get /chains/main/blocks/$hash/helpers/current_level | jq '.level')
        behind=$(( ${network}-${node} ))
        if [[ $flag = "status" ]];then
                if [[ $behind -gt 10 ]]; then
                        echo "Node is behind"
                else
                        echo "Node up to date"
                fi
        else
                echo -e "$(date "+%Y-%m-%d|%H:%M:%S")|\c"
                echo -e "$network|\c"
                echo -e "$node|\c"
                echo "$behind"
        fi
elif [[ -n "$flag" ]];then
        echo "Node Stopped"
fi
