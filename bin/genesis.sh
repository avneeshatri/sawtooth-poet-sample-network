sawset genesis -k /etc/sawtooth/keys/validator.priv -o config-genesis.batch

sawset proposal create -k /etc/sawtooth/keys/validator.priv \
-o config.batch \
sawtooth.consensus.algorithm.name=PoET \
sawtooth.consensus.algorithm.version=0.1 \
sawtooth.poet.report_public_key_pem="$(cat /etc/sawtooth/simulator_rk_pub.pem)" \
sawtooth.poet.valid_enclave_measurements=$(poet enclave measurement) \
sawtooth.poet.valid_enclave_basenames=$(poet enclave basename)



poet registration create -k /etc/sawtooth/keys/validator.priv -o poet.batch


sawset proposal create -k /etc/sawtooth/keys/validator.priv \
-o poet-settings.batch \
sawtooth.poet.target_wait_time=5 \
sawtooth.poet.initial_wait_time=25 \
sawtooth.publisher.max_batches_per_block=100 \
sawtooth.poet.block_claim_delay=1 \
sawtooth.poet.key_block_claim_limit=100000 \
sawtooth.poet.ztest_minimum_win_count=999999999



sawadm genesis config-genesis.batch config.batch poet.batch poet-settings.batch