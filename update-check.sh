#!/bin/bash

# You need to install JQ: https://github.com/stedolan/jq/

# Get a Personal Access Token for yourself from https://gitlab.com/profile/personal_access_tokens
gitlab_private_token="xxxxxxxxxxxxxxxxxxxxx"
tezos_dir="/home/tezos/tezos/"

# Don't change anything from here down

current=$(curl -s --header "PRIVATE-TOKEN: $gitlab_private_token" "https://gitlab.com/api/v4/projects/tezos%2Ftezos/repository/commits/?ref_name=mainnet" | jq -r '.[0].id')

myinstall=$(cd $tezos_dir && git log | head -n 1 | sed 's/commit //')

if [ -z "$current" ]; then
        # API call failed, retrieve API version from the last successful call
        current=$(<lastcurrentversion.txt)
else
        # API call worked, store hash for future use
        echo $current > lastcurrentversion.txt
fi

if [ "$current" == "$myinstall" ]; then
        echo "Your tezos install is up to date or the API didn't respond."
else
        echo "Your tezos install is behind: repo commit hash is $current, your install is $myinstall."
fi
