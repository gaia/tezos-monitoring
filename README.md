# Tezos Monitoring Tools
Tools to monitor your Tezos Node, Baker and Endorser

**blockheight.sh**: monitor if your node is up to date with the chain, by comparing your node's block height with network block height as published by TZscan.io's API (http://tzscan.io/api)

**bakingstatus.sh**: tells you if the baker process is running. It doesn't tell you if the password has been entered (in case your setup requires it) or that the baker is running properly.

**endorsingstatus.sh**: tells you if the endorser process is running. It doesn't tell you if the password has been entered (in case your setup requires it) or that the endorser is running properly.

PS: If you are baking with the ledger, these fine folks have created systemd entries to make it easier to run the node/baker/endorser:
https://github.com/etomknudsen/tezos-baking
