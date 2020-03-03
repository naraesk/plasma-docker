# Plasma Docker Control

This is a simple plasma applet for KDE Plasma 5 to control docker containers via docker-compose. It is not designed to be a complete user interface for docker, but it provides an convenient way to start (docker-compose up) and stop (docker-compose stop) selected containers. 

I maid this for my own convenience and it only has a minimal ui. Feel free to open an issue if you want more features and I'll have a look if I might find some time.

### Supported Features
* start docker-compose stack (`docker compose -f YAML_FILE up`)
* start service (`docker compose -f YAML_FILE up SERVICE`)
* stop docker-compose stack (`docker compose -f YAML_FILE stop`)
* stop service (`docker compose -f YAML_FILE stop SERVICE`)
* updates automatically if status changed externally (delay up to 30s)

### Installation

Please install docker-compose. Most distributions should provide packages for it. Then, run `install.sh` to install the plasmoid or run the following commands manually.

1. `mkdir biuld && cd build`
2. ```cmake -DCMAKE_INSTALL_PREFIX=`kf5-config --install-prefix` -DCMAKE_BUILD_TYPE=Release -DKDE_INSTALL_LIBDIR=lib -DKDE_INSTALL_USE_QT_SYS_PATHS=ON ../```
3. `make`
4. `sudo make install`
5. `kquitapp5 plasmashell`
6. `kstart5 plasmashell`

For Arch Linux there is a package availabe via AUR: https://aur.archlinux.org/packages/plasma5-applets-docker/
