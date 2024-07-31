#!/bin/bash
priority_fee="500000"
SENDER_ADDRESS=$1
RPC_URL1="https://wallet.okex.org/fullnode/sol/discover/rpc"  # 替换为 Solana 区块链节点的 URL 地址
REWARD_THRESHOLD=0.02

i=$2;
while [ $i -lt 110 ];
do
   echo $i;
   address=`cat /root/addr/id$i.json`
   key="/root/id/id$i.json"
   balance=`solana balance --keypair $key | cut -d ' ' -f1`
   if [ `echo "($balance - 0.02) > $REWARD_THRESHOLD " | bc` -eq 1 ] ; then
	   money=`echo "$balance - 0.02 " | bc | awk '{printf "%.3f",$0}' `
	   echo $address' balance is '$balance',claim '$money
	   solana transfer --from $key  $SENDER_ADDRESS  $money     --allow-unfunded-recipient     --with-compute-unit-price 10
	   sleep 3
   else
	   echo $address' balance is '$balance',not claim'
   fi
   i=`expr $i + 1`;
done
