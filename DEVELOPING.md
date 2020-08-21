# Developing

## Building the image

### Base OS image

Moved in [fam4r/docker-ndnsim-os](https://github.com/fam4r/docker-ndnsim-os/DEVELOPING.md).

### ndnSIM image

```bash
$ NDNSIM_DOCKER_VERSION=2.8
$ cd ${NDNSIM_DOCKER_VERSION}
$ docker build --no-cache --tag localndnsim:${NDNSIM_DOCKER_VERSION} .
```

## ndnSIM tests

Run the docker image: [command](./README.md#docker)

```bash
# cd ~/ndnSIM/ns-3/
```

Notes:
- console logging can be enabled by adding the `NS_LOG` variable
  - example: `NS_LOG=ndn.Producer:ndn.Consumer`
- visualizer can be tested (if installed) appending the `--vis` option to the
  `waf` command

### C++ tests

```bash
# ./waf --run=ndn-simple
```

### Python 2 tests
```bash
# ./waf --pyrun=src/ndnSIM/examples/ndn-simple.py
```

### Python 3 tests

```bash
# ./waf --python=/usr/bin/python3 --pyrun=src/ndnSIM/examples/ndn-simple.py
```
