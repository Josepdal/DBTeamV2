DBTeam-bot
============

Installation
------------

Debian/Ubuntu and derivatives:
```bash
# Tested on Ubuntu 16.04. (please use release "stable", isn't working on stretch/testing)
sudo apt-get install git redis-server libconfig8-dev libjansson-dev lua5.2 liblua5.2-dev lua-lgi glib-2.0 libnotify-dev libssl-dev libssl1.0.0 luarocks
```

Arch:
```bash
sudo yaourt -S git redis-server libconfig8-dev libjansson-dev lua5.2 liblua5.2-dev lua-lgi glib-2.0 libnotify-dev libssl-dev libssl1.0.0 luarocks
```

Fedora:
```bash
sudo dnf install git redis-server libconfig8-dev libjansson-dev lua5.2 liblua5.2-dev lua-lgi glib-2.0 libnotify-dev libssl-dev libssl1.0.0 luarocks
```

After those dependencies, lets install the bot
```bash
git clone https://github.com/Josepdal/DBTeamV2.git
cd DBTeamV2
chmod +x launch.sh
sudo ./launch.sh install
./launch.sh configure
./launch.sh # Will ask you for a phone number & confirmation code.
```
