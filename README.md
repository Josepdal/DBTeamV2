DBTeamV2
========

Installation
------------

Debian/Ubuntu and derivatives:
```bash
# Tested on Ubuntu 16.04 and Debian 8.7.1 stable. (please use release "stable", isn't working on stretch/testing)
sudo apt-get install git redis-server libconfig8-dev libjansson-dev lua5.2 liblua5.2-dev lua-lgi glib-2.0 libnotify-dev libssl-dev libssl1.0.0 make libstdc++6 g++-4.9 unzip tmux -y

# If you have errors (maybe you'll need this on Ubuntu)
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y; sudo apt-get autoclean; sudo apt-get update
sudo apt-get install git redis-server libconfig8-dev libjansson-dev lua5.2 liblua5.2-dev lua-lgi glib-2.0 libnotify-dev libssl-dev libssl1.0.0 make libstdc++6 g++-4.9 unzip libreadline-gplv2-dev libreadline5-dev tmux -y
```

Arch:
```bash
sudo pacman -S yaourt
sudo yaourt -S git redis-server libconfig8-dev libjansson-dev lua5.2 liblua5.2-dev lua-lgi glib-2.0 libnotify-dev libssl-dev libssl1.0.0 tmux
```

Fedora:
```bash
sudo dnf install git redis-server libconfig8-dev libjansson-dev lua5.2 liblua5.2-dev lua-lgi glib-2.0 libnotify-dev libssl-dev libssl1.0.0 tmux
```

After those dependencies, lets install the bot
```bash
 git clone https://github.com/Josepdal/DBTeamV2.git
 cd DBTeamV2
 chmod +x launch.sh
 ./launch.sh install # you can use the option --no-download and only configure DBTeam
 ./launch.sh # Will ask you for a phone number & confirmation code.
```

Execute DBTeam anywhere:
```bash
echo "alias dbteam='cd; cd DBTeamV2; bash `pwd`/launch.sh; cd'" >> ~/.bashrc
# Then... you can execute DBTeam easily:
dbteam
```


Tmux:
```bash
./launch.sh tmux # create a session tmux

./launch.sh attach # if you want back to tmux session

./launch.sh kill # close session tmux
```

DBTeamV2 Developers:
--------------------
[![https://telegram.me/Josepdal](https://img.shields.io/badge/%F0%9F%92%AC_Telegram-Josepdal-blue.svg)](https://t.me/Josepdal)
[![https://telegram.me/Jarriz](https://img.shields.io/badge/%F0%9F%92%AC_Telegram-Jarriz-blue.svg)](https://t.me/Jarriz)
[![https://telegram.me/iicc1](https://img.shields.io/badge/%F0%9F%92%AC_Telegram-iicc1-blue.svg)](https://t.me/iicc1)

DBTeamV2 Channels:
--------------------
[![https://telegram.me/DBTeamEN](https://img.shields.io/badge/%F0%9F%92%AC_Telegram-DBTeamEN-blue.svg)](https://t.me/DBTeamEN)
[![https://telegram.me/DBTeamES](https://img.shields.io/badge/%F0%9F%92%AC_Telegram-DBTeamES-blue.svg)](https://t.me/DBTeamES)

Special thanks to:
==================
Yago Pérez and his telegram-bot
-------------------------------
[![https://telegram.me/Yago_Perez](https://img.shields.io/badge/%F0%9F%92%AC_Telegram-Yago_Perez-blue.svg)](https://t.me/Yago_Perez)
[![https://github.com/yagop/telegram-bot](https://img.shields.io/badge/%F0%9F%92%AC_GitHub-Telegram_bot-green.svg)](https://github.com/yagop/telegram-bot)
Riccardo and his GroupButler
----------------------------
[![https://telegram.me/Riccardo](https://img.shields.io/badge/%F0%9F%92%AC_Telegram-bac0nnn-blue.svg)](https://t.me/bac0nnn)
[![https://github.com/RememberTheAir/GroupButler](https://img.shields.io/badge/%F0%9F%92%AC_GitHub-GroupButler-green.svg)](https://github.com/RememberTheAir/GroupButler)
vysheng and his new tg-cli
--------------------------
[![https://valtman.name/telegram-cli](https://img.shields.io/badge/%F0%9F%92%AC_WebPage-valtman.name-red.svg)](https://valtman.name/telegram-cli)
[![https://github.com/vysheng](https://img.shields.io/badge/%F0%9F%92%AC_GitHub-vysheng-green.svg)](https://github.com/vysheng)
rizaumami and his tdcli lib
---------------------------
[![https://github.com/rizaumami/tdcli.lua](https://img.shields.io/badge/%F0%9F%92%AC_GitHub-rizaumami-green.svg)](https://github.com/rizaumami/tdcli.lua)

Thanks to [@Reload_Life](https://t.me/Reload_Life) for [settings design](https://github.com/Reload-Life).
