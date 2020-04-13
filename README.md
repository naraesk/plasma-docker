# Plasma Docker Control

This is a simple plasma applet for KDE Plasma 5 to control docker containers via docker-compose. It is just a convenience UI for managing docker containers. I made this for my own convenience to manage my local development setup based on docker-compose. Feel free to open an issue if you want more features and I'll have a look if I might find some time.

![Screenshot](../../wiki/screenshots/ui%20v2.2.0.png)

### Features
* show status of container (with some delay)
* start and stop stacks (`docker-compose up` and `docker-compose stop`)
* start and stop services (`docker-compose up SERVICE` and `docker-compose stop SERVICE`)
* start shell for services (`docker-compose exec SERVICE sh`)
* open public port in browser
* edit compose file in default text editor
* show log files (`docker-compose logs`)

## Packages

[![Logo Arch Linux](../../wiki/logos/arch_linux.png)](https://aur.archlinux.org/packages/plasma5-applets-docker/)

## Manual Installation

Please install docker-compose. Most distributions should provide packages for it. Then, run `install.sh` to install the plasmoid or run the following commands manually.

1. `mkdir build && cd build`
2. ```cmake -DCMAKE_INSTALL_PREFIX=`kf5-config --install-prefix` -DCMAKE_BUILD_TYPE=Release -DKDE_INSTALL_LIBDIR=lib -DKDE_INSTALL_USE_QT_SYS_PATHS=ON ../```
3. `make`
4. `sudo make install`
5. `kquitapp5 plasmashell`
6. `kstart5 plasmashell`


