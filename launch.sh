#!/usr/bin/env bash

THIS_DIR=$(cd $(dirname $0); pwd)
cd $THIS_DIR

config_lines=(
  	'default_profile = "dbteam";'
  	''
  	'dbteam = {'
  	'	config_directory = "../bot";'
  	'	test = false;'
  	'	msg_num = true;'
  	'	lua_script = "bot.lua";'
  	'	log_level = 2;'
  	'	logname = "log.txt";'
  	'	verbosity = 100;'
  	'	wait_dialog_list = true;'
  	'}'
)

function install_luarocks() {
  git clone https://github.com/keplerproject/luarocks.git
  cd luarocks
  git checkout tags/v2.3.0-rc2 # Release Candidate

  PREFIX="$THIS_DIR/.luarocks"

  ./configure --prefix=$PREFIX --sysconfdir=$PREFIX/luarocks --force-config

  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting."; exit $RET;
  fi

  make build && make install
  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting.";exit $RET;
  fi

  cd ..
  rm -rf luarocks
}

function install_rocks() {
  ./.luarocks/bin/luarocks install luasec
  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting."; exit $RET;
  fi

  ./.luarocks/bin/luarocks install lbase64 20120807-3
  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting."; exit $RET;
  fi

  ./.luarocks/bin/luarocks install luafilesystem
  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting."; exit $RET;
  fi

  ./.luarocks/bin/luarocks install lub
  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting."; exit $RET;
  fi

  ./.luarocks/bin/luarocks install luaexpat
  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting."; exit $RET;
  fi

  ./.luarocks/bin/luarocks install redis-lua
  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting."; exit $RET;
  fi

  ./.luarocks/bin/luarocks install lua-cjson
  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting."; exit $RET;
  fi

  ./.luarocks/bin/luarocks install fakeredis
  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting."; exit $RET;
  fi

  ./.luarocks/bin/luarocks install xml
  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting."; exit $RET;
  fi

  ./.luarocks/bin/luarocks install feedparser
  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting."; exit $RET;
  fi

  ./.luarocks/bin/luarocks install serpent
  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting."; exit $RET;
  fi
}

function install() {
  git pull
  git submodule update --init --recursive
  install_luarocks
  install_rocks

  if [ -d /mnt/c/Windows ]; then
    echo "Patching bot.lua for Windows 10 support..."
    sed -i '5d' bot/bot.lua
    sed -i '5d' bot/bot.lua
    sed -i '5i\require("bot/utils")' bot/bot.lua
    sed -i '6i\require("bot/permissions")' bot/bot.lua
    sed -i '7i\--File patched to support W10' bot/bot.lua
  fi

}

function is_ready() {
	if [[ `grep -wi "dbteam" ~/.telegram-cli/$1` ]]; then
		echo true
	fi
}

function do_file() {
	local lines
	for i in ${!config_lines[@]}; do
		lines+=${config_lines[$i]}"\n"
	done
	echo -e $lines >> ~/.telegram-cli/${1}
}

function character() {
	letter=$(($1 - 1))
	string=`echo $2`
	echo ${string:${letter}:1}
}

function subprocess() {
	if [[ `is_ready "config"` ]]; then
			rm -r ~/.telegram-cli/config
			for i in 25 50 75 100; do
				printf "\rConfiguring... [%i%%]" $i
				sleep 0.5
			done
			printf "\nDone\n"
			do_file config
			chmod +x ./bin/telegram-cli
	fi
}

case `character 1 "$1"` in
-)
	case `character 2 "$1"` in
	i)
		install
		subprocess
	esac
	exit
;;
esac

case $1 in
  install)
  install
  subprocess
esac
./bin/telegram-cli --json
