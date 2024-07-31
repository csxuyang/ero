#!/bin/bash
priority_fee="500000"
RPC_URL1="https://wallet.okex.org/fullnode/sol/discover/rpc"  # 替换为 Solana 区块链节点的 URL 地址
REWARD_THRESHOLD=0.001
TRANS_SOL=0.01
SOURCE_KEY=/root/id/id0.json

i=$1;
while [ $i -lt 33 ];
do
   echo $i;
   address=`cat /root/addr/id$i.json`
   key="/root/id/id$i.json"
   balance=`solana balance --keypair $key | cut -d ' ' -f1`
   if [ `echo "$balance < $REWARD_THRESHOLD " | bc` -eq 1 ]; then
	   echo $address' balance is '$balance',trans '$TRANS_SOL
	   solana transfer --from $SOURCE_KEY  $address  $TRANS_SOL    --allow-unfunded-recipient     --with-compute-unit-price 10
	   sleep 3
   else
	   echo $address' balance is '$balance',not trans'
   fi
   i=`expr $i + 1`;
done
