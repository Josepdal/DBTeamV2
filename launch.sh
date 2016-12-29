#!/bin/bash
# Launch created by @Jarriz, @Josepdal and @iicc1
tgcli_version=1222
LOGFILE_MAXSIZE=25
dbteam_dir="DBTeamV2"
config_lines=(
  	'default_profile = "dbteam";'
  	''
  	'dbteam = {'
  	'	config_directory = "../'${dbteam_dir}'/bot";'
  	'	test = false;'
  	'	msg_num = true;'
  	'	lua_script = "bot.lua";'
  	'	log_level = 2;'
  	'	logname = "log.txt";'
  	'	verbosity = 100;'
  	'	wait_dialog_list = true;'
  	'}'
)

lualibs=(
  	'luasec'
  	'lbase64 20120807-3'
  	'luafilesystem'
  	'lub'
  	'luaexpat'
  	'redis-lua'
  	'lua-cjson'
  	'fakeredis'
  	'xml'
  	'feedparser'
  	'serpent'
)

function install_libs_lua() {
  today=`date +%F`
  if [[ ! -d "logs" ]]; then mkdir logs; fi
  if [[ -f "logs/logluarocks_${today}.txt" ]]; then rm logs/logluarocks_${today}.txt; fi
  local i file
  for i in ${!lualibs[@]}; do
    printf "\rInstalling lualibs... [${i}/${#lualibs[@]}]\t${lualibs[i]}                         "
    luarocks install ${lualibs[$i]} &>> logs/logluarocks_${today}.txt
  done
  sleep 0.2
  printf "\rInstalling lualibs... [11/11]"
  printf "\nLogfile created: `pwd`/logs/logluarocks_${today}.txt\nDone\n"
}

function install() {
  install_libs_lua
  if [ -d /mnt/c/Windows ]; then
    echo "Patching bot.lua for Windows 10 support..."
    sed -i '5d' bot/bot.lua
    sed -i '5d' bot/bot.lua
    sed -i '5i\require("bot/utils")' bot/bot.lua
    sed -i '6i\require("bot/permissions")' bot/bot.lua
    sed -i '7i\--File patched to support W10' bot/bot.lua
  fi
}

function do_file() {
	local lines
	for i in ${!config_lines[@]}; do
		lines+=${config_lines[$i]}"\n"
	done
	echo -e $lines > ~/.telegram-cli/${1}
}

function character() {
	string=`echo "$2"`
	echo ${string:${letter}:1}
}

function update() {
  git checkout .
  git pull
}

function configure() {
  if [[ ${1} != "--no-download" ]]; then
			printf "Downloading telegram-cli v${tgcli_version}... [0%%]"
			wget https://valtman.name/files/telegram-cli-${tgcli_version} &>/dev/null
      printf "\r                                                    "
      if [ ! -d "bin" ]; then mkdir bin; fi
			mv telegram-cli-${tgcli_version} ./bin/telegram-cli
  fi
			for i in 25 50 75 100; do
				printf "\rConfiguring... [%i%%]" $i
				sleep 0.5
			done
			printf "\nDone\n"
			do_file config
			chmod +x ./bin/telegram-cli
}

function start_bot() {
  ./bin/telegram-cli ${1}
}

function show_logo_slowly() {
  declare -A logo
  seconds="0.008"
  logo[1]="____  ____ ______"
  logo[2]="|    \|  _ )_   _|___ ____   __  __"
  logo[3]="| |_  )  _ \ | |/ .__|  _ \_|  \/  |"
  logo[4]="|____/|____/ |_|\____/\_____|_/\/\_|  v2"
  printf "\033[38;5;208m\t"
  for i in ${!logo[@]}; do
    for x in `seq 0 ${#logo[$i]}`; do
      printf "${logo[$i]:$x:1}"
      sleep $seconds
    done
    printf "\n\t"
  done
  printf "\n"
}

function show_logo() {
 #Adding some color. By @iicc1 :D
 echo -e "\033[38;5;208m"
 echo -e "\t____  ____ ______"
 echo -e "\t|    \|  _ )_   _|___ ____   __  __"
 echo -e "\t| |_  )  _ \ | |/ .__|  _ \_|  \/  |"
 echo -e "\t|____/|____/ |_|\____/\_____|_/\/\_|  v2"
 echo -e "\n\e[36m"
}

case `character 0 "$1"` in
-)
	case `character 1 "$1"` in
	i)
    show_logo_slowly
		install ;;
  u)
    show_logo
    update ;;
  c)
    show_logo
    configure ${2};;
  esac
  exit
;;
esac

case $1 in
  install)
    show_logo_slowly
    install
    exit ;;
  update)
    show_logo
    update
    exit ;;
  configure)
    show_logo
    configure "${2}"; exit ;;
  *)
  if [[ `echo $(du -bsh bot/log.txt) | cut -d "M" -f1` -gt "${LOGFILE_MAXSIZE}" ]]; then sudo rm -rf ./bot/log.txt; fi
    show_logo
    start_bot ${2}
esac
