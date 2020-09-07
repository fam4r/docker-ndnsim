# Troubleshooting

WIP

## General considerations

If any error occurs and you are running simulations from a separate repository (best practice), try to copy source files into the NS-3 `scratch/` folder, then build and run. If it works directly into the NS-3 folder, then the utility scripts into the scenario template are broken.

## `waf configure` errors

### `optimized` vs `debug`

Check the `docker-ndnsim` version you are using, e.g. `2.8` uses a compiled version of ndnSIM in `optimized` mode (to run actual simulations), the `2.8-debug` version is compiled in `debug` mode (where logging is enabled).

So if you proceed to configure your project with debug enabled but you are using the optimized version of ndnSIM (and vice versa), you may encounter in errors like the one below:

```bash
ndn@5ed4cfd40ce9:~/simulation$ ./waf configure --debug
Setting top to                           : /home/ndn/simulation
Setting out to                           : /home/ndn/simulation/build
Checking for 'gcc' (C compiler)          : /usr/bin/gcc
Checking for 'g++' (C++ compiler)        : /usr/bin/g++
Checking C++ compiler version            : 9.3.0
Checking supported CXXFLAGS              : -std=c++14
Checking supported LINKFLAGS             : -fuse-ld=gold
Checking for program 'pkg-config'        : /usr/bin/pkg-config
Checking for pkg-config version >= '0.0.0' : yes
Checking for ns3-core                      : not found
NS-3 or one of the required NS-3 modules not found
NS-3 needs to be compiled and installed somewhere.  You may need also to set PKG_CONFIG_PATH variable in order for configure find installed NS-3.
For example:
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH ./waf configure

(complete log in /home/ndn/simulation/build/config.log)
```

If you inspect the `build/config.log` file you can notice the error:

```
Checking for ns3-core
['/usr/bin/pkg-config', '--cflags', '--libs', 'libns3-dev-core-debug']
err: Package libns3-dev-core-debug was not found in the pkg-config search path.
Perhaps you should add the directory containing `libns3-dev-core-debug.pc'
to the PKG_CONFIG_PATH environment variable
No package 'libns3-dev-core-debug' found
```

Which basically tells you that `debug` libs are searched, but they are not present (because the `-optimized` ones are!).

**SOLUTION**: for `2.8-debug` you have to run `./waf configure --debug`, for `2.8` (optimized) you have to run `./waf configure`.

## Other references

https://ndnsim.net/current/faq.html