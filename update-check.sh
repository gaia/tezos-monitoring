#!/bin/bash

# You need to install JQ: https://github.com/stedolan/jq/

# Get a Personal Access Token for yourself from https://gitlab.com/profile/personal_access_tokens
gitlab_private_token="xxxxxxxxxxxxxxxxxxxxx"
tezos_dir="/home/tezos/tezos/"

# Don't change anything from here down

current=$(curl -s --header "PRIVATE-TOKEN: $gitlab_private_token" "https://gitlab.com/api/v4/projects/tezos%2Ftezos/repository/commits/?ref_name=betanet" | jq -r '.[0].id')
myinstall=$(cd $tezos_dir && git log | head -n 1 | sed 's/commit //')

if [ "$current" == "$myinstall" ]; then
       echo "Your tezos install is up to date: your install commit hash is $myinstall."
else
       echo "Your tezos install is behind: repo commit hash is $current, your install is $myinstall."
fi
