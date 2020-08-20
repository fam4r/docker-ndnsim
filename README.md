# ndnSIM Docker image

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/emrevoid/ndnsim?logo=docker)
![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/emrevoid/ndnsim?logo=docker)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/emrevoid/ndnsim?logo=docker)
![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/emrevoid/ndnsim?logo=docker)

![NDN logo](https://ndnsim.net/current/_static/ndn-logo.png)

**Unofficial** docker implementation of [ndnSIM](http://ndnsim.net/).

`Dockerfile`s can be found in the [repository page](https://github.com/fam4r/docker-ndnsim).

ndnSIM is a patched version of the popular [ns-3](https://www.nsnam.org/) network simulator, for details please visit the [ndnSIM Introduction page](https://ndnsim.net/current/intro.html).

Features about that Docker image:
- Python 2 for old simulations support (v2.8+ only)
- [`pipenv`](https://github.com/pypa/pipenv) installed for your custom Python dependencies (v2.8+ only)
- [`renv`](https://github.com/rstudio/renv) installed for your custom R dependencies (v2.8+ only)
- `docker-compose` with custom volume support for your simulations
- visualizer dependencies installed

**Feel free to contribute with issues/PRs!**

## Usage

Logging can be enabled using the `NS_LOG` variable, e.g. `NS_LOG=ndn.Producer:ndn.Consumer`.

### `docker`

If you want to directly run a simulation into the docker container you can use
the following command.

```bash
$ docker run \
    -u root \
    -it \
    -v ~/hub/docker-ndnsim/simulation/:/simulation \
    emrevoid/ndnsim:2.8 \
    /home/ndn/ndnSIM/ns-3/waf --run=bench-simulator
```

If you want to spawn a shell replace the last command line with `bash`, then
execute the command. You can now type commands into the docker container. To run
a simulation move into the proper location and run the `waf` command.

```bash
~/ndnSIM/ns-3# ./waf --run=bench-simulator
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
$ docker-compose run --rm ndnsim
```

Using `docker-compose` you will not need to use `x11docker`.
