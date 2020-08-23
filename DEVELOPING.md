# Developing

## Building the image

### Base OS image

Moved in [fam4r/docker-ndnsim-os](https://github.com/fam4r/docker-ndnsim-os/blob/master/DEVELOPING.md).

### ndnSIM image

```bash
$ NDNSIM_DOCKER_VERSION=2.8
$ cd ${NDNSIM_DOCKER_VERSION}
$ docker build --no-cache --tag localndnsim:${NDNSIM_DOCKER_VERSION} .
```

## Adding a new version

The [main page on ndnSIM website](https://ndnsim.net/current/) reports all the ndnSIM versions.

If a new version is available:
- check the [release notes page](https://ndnsim.net/current/RELEASE_NOTES.html)
  - if a new OS version has been adopted, create the Docker image [fam4r/docker-ndnsim-os](https://github.com/fam4r/docker-ndnsim-os/blob/master/DEVELOPING.md)
    - you can also check the ["Downloading and Compiling ndnSIM" page](https://ndnsim.net/current/getting-started.html)
- take note of the versions for NFD and ndn-cxx
- Create a folder for the new version: `mkdir 2.8`
- Copy the previous version Dockerfile into the new folder `cp 2.7/Dockerfile 2.8` (workaround for https://github.com/docker/hub-feedback/issues/759)
- edit the `Dockerfile` tags/commits
  - https://github.com/named-data-ndnSIM/ns-3-dev
  - https://github.com/named-data-ndnSIM/pybindgen
  - https://github.com/named-data-ndnSIM/ndnSIM
- `ln -sr 2.8/Dockerfile Dockerfile`
- edit the `docker-compose.yml` file with the new version
- commit the new `Dockerfile`
- `git tag 2.8`
- `git push`
- `git push origin 2.8`

## Triggering the automated builds

Upstream images are built by Docker Cloud at every repository push.

Unfortunately Docker automated builds using git tags are not triggered at each push (and it also cannot be done via GUI!).

[It seems](https://github.com/docker/hub-feedback/issues/620) that the only way to accomplish the task is to delete upstream tags and re-push them again: it will trigger Docker Cloud to rebuild the image.

```bash
$ git push --delete origin 2.8 # and for other tags if necessary
```

Wait for the GitHub mirrored repository to get the updates, then push the tags again.

```bash
$ git push --tags origin
```

## Running ndnSIM tests

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
