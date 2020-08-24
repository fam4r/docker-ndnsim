# ndnSIM Docker image

![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/emrevoid/ndnsim/2.8?logo=docker)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/emrevoid/ndnsim?logo=docker)
![Docker Pulls](https://img.shields.io/docker/pulls/emrevoid/ndnsim?logo=docker)
![Docker Stars](https://img.shields.io/docker/stars/emrevoid/ndnsim?logo=docker)
![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/emrevoid/ndnsim?logo=docker)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/emrevoid/ndnsim/2.8?logo=docker)

![NDN logo](https://ndnsim.net/current/_static/ndn-logo.png)

**Unofficial** docker implementation of [ndnSIM](http://ndnsim.net/).

`Dockerfile`s can be found in the [repository page](https://github.com/fam4r/docker-ndnsim).

ndnSIM is a patched version of the popular [ns-3](https://www.nsnam.org/) network simulator, for details please visit the [ndnSIM Introduction page](https://ndnsim.net/current/intro.html).

## Features

Features about that Docker image:
- providing both `optimized` and `debug` compiled ndnSIM (v2.8+ only)
- Python 2 for old simulations support (v2.8+ only)
- [`pipenv`](https://github.com/pypa/pipenv) installed for your custom Python (2 & 3) dependencies (v2.8+ only)
- R & [`renv`](https://github.com/rstudio/renv) installed for your custom R dependencies (v2.8+ only)
- `docker-compose` with custom volume support for your simulations
- visualizer dependencies installed

**Feel free to contribute with issues/PRs!**

## Usage

A simulation can be every NDN `waf` project in your drive, you just need to
specify the absolute path.

### A note on logging

Logging can be enabled using the `NS_LOG` variable, e.g. `NS_LOG=ndn.Producer:ndn.Consumer`.

As reported in ndnsim.net, to show logs you need ndnSIM to be compiled in `debug` mode.

From version 2.8 this Docker image supports `optimized` mode by default (e.g. `2.8` tag)
and `debug` mode appending `-debug` (e.g. `2.8-debug`): clearly you need to edit the `docker run`
commands you see in this doc and in `docker-compose.yml` file.

### `docker`

If you want to directly run a simulation into the docker container you can use
the following command.

```bash
$ docker run \
    -u $(id -u):$(id -g) \
    -it \
    emrevoid/ndnsim:2.8 \
    /home/ndn/ndnSIM/ns-3/waf --run=bench-simulator
```

If you want to spawn a shell replace the last command line with `bash`, then
execute the command. You can now type commands into the docker container. To run
a simulation move into the proper location and run the `waf` command.

```bash
$ ./waf --run=bench-simulator
```

#### Separate scenario repository

As reported into [ndnsim.net](https://ndnsim.net/current/getting-started.html#simulating-using-ndnsim)
you can write and run simulations directly inside the NS-3 `scratch/` or `src/ndnSIM/examples/` folders.

But for separation of concerns it is recommended to use a [separated repository](https://github.com/named-data-ndnSIM/scenario-template) for your scenario stuff (simulation sources, extensions, graph scripts...).

To make it available into the dockerized ndnSIM you can use the `--volume` option to mount local files into the isolated environment.

```bash
$ docker run \
    -u $(id -u):$(id -g) \
    -it \
    -v ~/hub/docker-ndnsim/simulation/:/simulation \
    emrevoid/ndnsim:2.8 \
    /simulation/waf --run=simulation-source-file
```

#### Run with visualizer

To run the visualizer you need to use the `--vis` option to the `waf` command.

Install [x11docker](https://github.com/mviereck/x11docker) to securely run the
visualizer GUI.
```bash
$ x11docker \
    -- -v ~/hub/docker-ndnsim/simulation/:/simulation \
    -- emrevoid/ndnsim:2.8 \
    /home/ndn/ndnSIM/ns-3/waf --run=bench-simulator --vis
```

If you don't want to use it for any reason, check out their
[wiki](https://github.com/mviereck/x11docker/wiki/Short-setups-to-provide-X-display-to-container#sharing-host-x-display-for-single-applications).

Example:

```bash
$ xhost +SI:localuser:$(id -un)
$ docker run --rm \
    -it \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v ~/hub/docker-ndnsim/simulation/:/simulation \
    --ipc=host \
    --user $(id -u):$(id -g) \
    --cap-drop=ALL \
    --security-opt=no-new-privileges \
    emrevoid/ndnsim:2.8 \
    /home/ndn/ndnSIM/ns-3/waf --run=bench-simulator --vis
```

### `docker-compose`

Into the `docker-compose.yml` file you can edit the `volumes` and `entrypoint`
entries according to your simulation location.

Comment the `entrypoint` entry if you want to spawn the container shell.

```bash
$ UID=$(id -u) GID=$(id -g) docker-compose run --rm ndnsim
```

Using `docker-compose` you will not need to use `x11docker`.

### Using `renv`

From [Using renv with Docker](https://rstudio.github.io/renv/articles/docker.html).

```bash
$ RENV_PATHS_CACHE_HOST=$(pwd)/simulation/renv_modules
$ RENV_PATHS_CACHE_CONTAINER=/home/ndn/renv_modules
$ docker run \
    -u $(id -u):$(id -g) \
    -it \
    -e "RENV_PATHS_CACHE=${RENV_PATHS_CACHE_CONTAINER}" \
    -v "${RENV_PATHS_CACHE_HOST}:${RENV_PATHS_CACHE_CONTAINER}" \
    emrevoid/ndnsim:2.8 \
    /home/ndn/ndnSIM/ns-3/waf --run=bench-simulator
```

For the `docker-compose` version just add the proper options as `yml` entries.

## Thanks

- [seintzz](https://github.com/seintzz)
