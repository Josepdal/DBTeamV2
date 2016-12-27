# Launch created by @Jarriz, @Josepdal and @iicc1)
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

function install_libs_lua() {
  today=`date +%F`
  lualibs=(
    "luasec"
    "lbase64 20120807-3"
    "luafilesystem"
    "lub"
    "luaexpat"
    "redis-lua"
    "lua-cjson"
    "fakeredis"
    "xml"
    "feedparser"
    "serpent"
  )
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

function subprocess() {
			for i in 25 50 75 100; do
				printf "\rConfiguring... [%i%%]" $i
				sleep 0.5
			done
			printf "\nDone\n"
			do_file config
			chmod +x ./bin/telegram-cli
}

function start_bot() {
  ./bin/telegram-cli
}

function show_logo_slowly() {
  seconds="0.009"
  logo1="____  ____ ______"
  logo2="|    \|  _ )_   _|___ ____   __  __"
  logo3="| |_  )  _ \ | |/ .__|  _ \_|  \/  |"
  logo4="|____/|____/ |_|\____/\_____|_/\/\_|  v2"
  printf "\033[38;5;208m\t"
  for x in `seq 0 ${#logo1}`; do
    printf "${logo1:$x:1}"
    sleep $seconds
  done
  printf "\n\t"
  for x in `seq 0 ${#logo2}`; do
    printf "${logo2:$x:1}"
    sleep $seconds
  done
  printf "\n\t"
  for x in `seq 0 ${#logo3}`; do
    printf "${logo3:$x:1}"
    sleep $seconds
  done
  printf "\n\t"
  for x in `seq 0 ${#logo4}`; do
    printf "${logo4:$x:1}"
    sleep $seconds
  done
  printf "\e[36m\n\n"
}

function show_logo() {
 #Adding some color. By @iicc1 :D
 echo -e "\033[38;5;208m"
 echo -e "      ____  ____ _____                        "
 echo -e "     |    \|  _ )_   _|___ ____   __  __      "
 echo -e "     | |_  )  _ \ | |/ .__|  _ \_|  \/  |     "
 echo -e "     |____/|____/ |_|\____/\_____|_/\/\_|     "
 echo -e "                                              \033[0;00m"
 echo -e "\e[36m"
}

case `character 1 "$1"` in
-)
	case `character 2 "$1"` in
	i)
    show_logo_slowly
		install
		subprocess
	esac
	exit
;;
esac

case $1 in
  install)
    show_logo_slowly
    install
    subprocess
    exit ;;
  update)
    update
    exit ;;
  *)
    show_logo
    start_bot
esac
