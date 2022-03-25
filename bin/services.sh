node=$1
seed=$2

if [[ -z $node || -z $seed ]];then
	echo "Missing node address or seed"
	exit 1
fi
echo "Starting Starting"

nohup sawtooth-validator -vv --bind network:tcp://${node}:8800 --bind component:tcp://127.0.0.1:4004 --peering dynamic --endpoint tcp://${node}:8800 --seeds tcp://${seed}:8800 --scheduler parallel --network-auth trust &

sleep 20s

nohup  poet-validator-registry-tp -v &

sleep 10s

nohup settings-tp -v &

sleep 10s

nohup  intkey-tp-python -v &

sleep 10s

nohup poet-engine -vv -C tcp://127.0.0.1:5050 --component tcp://127.0.0.1:4004 &

sleep 10s

nohup  sawtooth-rest-api -v &

echo "Services started"