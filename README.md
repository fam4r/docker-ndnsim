# ndnSIM

**Unofficial** docker implementation of [ndnSIM](http://ndnsim.net/)

`Dockerfile`s can be found in the [repository page](https://bitbucket.org/emrevoid-uni/docker-ndnsim).

Currently supported versions 2.5 and 2.6.

The ndnSIM is NS-3 module that implements Named Data Networking (NDN)
communication model, the clean slate Internet design. ndnSIM is specially
optimized for simulation purposes and has a cleaner and more extensible internal
structure comparing to the existing NDN implementation (NDNx).

That image is based on Ubuntu 16.04 and provides all the dependencies to install
ndnSIM. It also installs the dependencies for NS-3 Python bindings in order to
run the visualizer module.

If you want to make some post-installation tests you can use the following
commands.

Notes:
- console logging can be disabled removing the `NS_LOG` variable
- visualizer can be tested (if installed) appending the `--vis` option to the
  `waf` command

```
cd ~/ndnSIM/ns-3/

# C++ TESTS
NS_LOG=ndn.Producer:ndn.Consumer ./waf --run=ndn-simple

# PYTHON2 TESTS
NS_LOG=ndn.Consumer:ndn.Producer ./waf --pyrun=src/ndnSIM/examples/ndn-simple.py

# PYTHON3 TESTS
NS_LOG=ndn.Consumer:ndn.Producer ./waf --python=/usr/bin/python3 --pyrun=src/ndnSIM/examples/ndn-simple.py 
```
