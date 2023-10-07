[`mutinynet`](https://mutinynet.com/) is a modified `signet` with 30s block time, which makes it ideal for an optimized development workflow on [braidpool](https://github.com/braidpool/braidpool).

This repo holds just a simple `Dockerfile` to deploy a local mutinynet node.

The `Dockerfile` is heavily inspired by [this](https://github.com/fedimint/fedimint/blob/a71267934a5ec2f0df28686fa21362386e762ca0/docker/mutinynet-bitcoind-docker/Dockerfile), originally written by Fedimint's [@douglaz](https://github.com/douglaz).

In order to avoid consuming Fedimint's resources (AWS bandwidth etc), I replaced the snapshot URL `https://fedi-public-snapshots.s3.amazonaws.com/bitcoind-mutinynet-signet.tar` for `https://pin.ski/3Q6PXte`, which is the exact same file (md5sum `da82b5c516a26ec6a349a923f8e3905b`) but hosted on IPFS via my personal (free) [Pinata](https://pinata.cloud) account.
