# Developing

## Building the image

### Base OS image

```bash
$ NDNSIM_DOCKER_OS_VERSION=20.04
$ cd base-${NDNSIM_DOCKER_OS_VERSION}
$ docker build --no-cache --tag localndnsimbase:${NDNSIM_DOCKER_OS_VERSION} .
```

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
