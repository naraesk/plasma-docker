# Plasma Docker Control

This is a simple plasma applet for KDE Plasma 5 to control docker containers via docker-compose. It is not designed to be a complete user interface for docker, but it provides an convenient way to start (docker-compose up) and stop (docker-compose down) selected images/containers. 

I maid this for my own convenience and it only has i minimal ui. If you have more talent at designing UIs please contribute! Feel free to open an issue if you want more features and I'look if I might find some time. But this project does not aim at being a KDE version of portainer.

### Supported Features
* start image (`docker compose -f YAML_FILE up`)
* stop image (`docker compose -f YAML_FILE down`)
* updates automatically if status changed externally

### Prerequisite

Please install docker-compose. Most distributions should provide packages for it.

### Installation
```
mkdir biuld
cd build
cmake -DCMAKE_INSTALL_PREFIX=`kf5-config --prefix` -DCMAKE_BUILD_TYPE=Release -DKDE_INSTALL_LIBDIR=lib -DKDE_INSTALL_USE_QT_SYS_PATHS=ON ../
make
make install
```

For Arch Linux there is a package availabe via AUR: https://aur.archlinux.org/packages/plasma5-applets-docker/
