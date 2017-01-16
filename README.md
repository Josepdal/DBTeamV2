DBTeam-bot
============

Installation
------------

Debian/Ubuntu and derivatives:
```bash
# Tested on Ubuntu 16.04. (please use release "stable", isn't working on stretch/testing)
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y && sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove && sudo apt-get autoclean && sudo apt-get install git redis-server libconfig8-dev libjansson-dev lua5.2 liblua5.2-dev lua-lgi glib-2.0 libnotify-dev libssl-dev libssl1.0.0 make libstdc++6 -y
```

Arch:
```bash
sudo yaourt -S git redis-server libconfig8-dev libjansson-dev lua5.2 liblua5.2-dev lua-lgi glib-2.0 libnotify-dev libssl-dev libssl1.0.0
```

Fedora:
```bash
sudo dnf install git redis-server libconfig8-dev libjansson-dev lua5.2 liblua5.2-dev lua-lgi glib-2.0 libnotify-dev libssl-dev libssl1.0.0
```

After those dependencies, lets install the bot
```bash
 git clone https://github.com/Josepdal/DBTeamV2.git
 cd DBTeamV2
 chmod +x launch.sh
 ./launch.sh install
 ./launch.sh # Will ask you for a phone number & confirmation code.
```
