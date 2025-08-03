#!/bin/bash

set -e

RPC_USER="admin"
RPC_PASS="pass"
BTC1="btc1"
BTC2="btc2"
WALLET="wallet"

wait_for_node() {
  local NODE=$1
  until docker exec "$NODE" bitcoin-cli -regtest -rpcuser=$RPC_USER -rpcpassword=$RPC_PASS getblockchaininfo > /dev/null 2>&1; do
    sleep 1
  done
}

ensure_wallet() {
  local NODE=$1
  local W=$2

  if ! docker exec "$NODE" bitcoin-cli -regtest -rpcuser=$RPC_USER -rpcpassword=$RPC_PASS listwallets | grep -q "$W"; then
    docker exec "$NODE" bitcoin-cli -regtest -rpcuser=$RPC_USER -rpcpassword=$RPC_PASS loadwallet "$W" 2>/dev/null || \
    docker exec "$NODE" bitcoin-cli -regtest -rpcuser=$RPC_USER -rpcpassword=$RPC_PASS createwallet "$W"
  fi
}
#test
wait_for_node $BTC1
wait_for_node $BTC2

ensure_wallet $BTC1 $WALLET
ensure_wallet $BTC2 $WALLET

FROM_ADDR=$(docker exec $BTC1 bitcoin-cli -regtest -rpcuser=$RPC_USER -rpcpassword=$RPC_PASS getnewaddress)
TO_ADDR=$(docker exec $BTC2 bitcoin-cli -regtest -rpcuser=$RPC_USER -rpcpassword=$RPC_PASS getnewaddress)

docker exec $BTC1 bitcoin-cli -regtest -rpcuser=$RPC_USER -rpcpassword=$RPC_PASS generatetoaddress 101 "$FROM_ADDR"

for i in {1..5}; do
  docker exec $BTC1 bitcoin-cli -regtest -rpcuser=$RPC_USER -rpcpassword=$RPC_PASS sendtoaddress "$TO_ADDR" 0.1
done

docker exec $BTC1 bitcoin-cli -regtest -rpcuser=$RPC_USER -rpcpassword=$RPC_PASS generatetoaddress 1 "$FROM_ADDR"

BAL1=$(docker exec $BTC1 bitcoin-cli -regtest -rpcuser=$RPC_USER -rpcpassword=$RPC_PASS getbalance)
BAL2=$(docker exec $BTC2 bitcoin-cli -regtest -rpcuser=$RPC_USER -rpcpassword=$RPC_PASS getbalance)

echo "$BTC1 balance: $BAL1 BTC"
echo "$BTC2 balance: $BAL2 BTC"


