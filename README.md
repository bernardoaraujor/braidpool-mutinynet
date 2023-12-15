[`mutinynet`](https://mutinynet.com/) is a modified `signet` with 30s block time, which makes it ideal for an optimized development workflow on [braidpool](https://github.com/braidpool/braidpool).

This repo holds just a simple `Dockerfile` to deploy a local mutinynet node.

The `Dockerfile` is heavily inspired by [this](https://github.com/fedimint/fedimint/blob/a71267934a5ec2f0df28686fa21362386e762ca0/docker/mutinynet-bitcoind-docker/Dockerfile), originally written by Fedimint's [@douglaz](https://github.com/douglaz).

In order to avoid consuming Fedimint's resources (AWS bandwidth etc), I replaced the snapshot URL `https://fedi-public-snapshots.s3.amazonaws.com/bitcoind-mutinynet-signet.tar` for `https://pin.ski/3Q6PXte`, which is the exact same file (md5sum `da82b5c516a26ec6a349a923f8e3905b`) but hosted on IPFS via my personal (free) [Pinata](https://pinata.cloud) account.

Currently, only `x86_64_linux_gnu`, `aarch64_linux_gnu`, and `arm64_apple_darwin` hosts are supported.

## cookie auth

For `braidpool` development, you will need access to the cookie file generated by `bitcoind` from inside the Docker container. Let's get the contents of this file.

First, find out the `pid` of the `custom-signet-bitcoin` container:
```
$ docker ps
CONTAINER ID   IMAGE                          COMMAND                  CREATED          STATUS          PORTS                                                                                                                                          NAMES
807509c37e86   custom-signet-bitcoin:latest   "bitcoind -rpcbind=:…"   27 minutes ago   Up 27 minutes   0.0.0.0:28332-28334->28332-28334/tcp, :::28332-28334->28332-28334/tcp, 0.0.0.0:38332-38334->38332-38334/tcp, :::38332-38334->38332-38334/tcp   custom-signet-node
```

then, open a terminal inside this container and print the contents of the cookie file:
```
$ docker exec -it 807509c37e86 /bin/bash
# cat ~/.bitcoin/signet/.cookie
__cookie__:0b55c9842de380b442b6fe9005904870d50ec6a2dd470e9b6dc063ac9c2b6919
# exit
```

then you can simply paste this content into a new file (available on your `braidpool` environment) and use its path for the `-rpccookiefile` CLI arg on `braidpool` node.

```
$ echo "__cookie__:0b55c9842de380b442b6fe9005904870d50ec6a2dd470e9b6dc063ac9c2b6919" > /path/to/cookiefile
./braidpool-node --rpccookiefile="/path/to/cookiefile" # other CLI args...
```
