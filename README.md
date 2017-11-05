# PLasma systemd Control

This is a simple plasma applet for KDE Plasma 5 to control systemd services.

### Supported Features
* start service (`sudo systemctl start SERVICE`)
* stop service (`sudo systemctl stop SERVICE`)
* updates automatically if status changed externally

### Installation
1. mkdir biuld
2. cd build
3. cmake -DCMAKE_INSTALL_PREFIX=`kf5-config --prefix` -DCMAKE_BUILD_TYPE=Release -DLIB_INSTALL_DIR=lib -DKDE_INSTALL_USE_QT_SYS_PATHS=ON ../
4. make
5. make install

### Prerequisite

To work properly, you must be able to run `sudo systemctl` without password. Usually you can achieve this be editing `/etc/sudoers` with visudo. 

