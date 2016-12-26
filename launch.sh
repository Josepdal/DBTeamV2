config_lines=(
  	'default_profile = "dbteam";'
  	''
  	'dbteam = {'
  	'	config_directory = "../DBTeam/bot";'
  	'	test = false;'
  	'	msg_num = true;'
  	'	lua_script = "bot.lua";'
  	'	log_level = 2;'
  	'	logname = "log.txt";'
  	'	verbosity = 100;'
  	'	wait_dialog_list = true;'
  	'}'
)

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

case `character 1 "$1"` in
-)
	case `character 2 "$1"` in
	i)
	if [[ `is_ready "config"` ]]; then
		printf "The file config is already configured\nDo you want make the file again? [Y/n] "
		read opt
		case $opt in
		"Y"|"y"|"S"|"s")
			rm -r ~/.telegram-cli/config
			for i in 25 50 75 100; do
				printf "\rConfiguring... [%i%%]" $i
				sleep 0.5
			done
			printf "\nDone\n"
			do_file config
			exit
		esac
	fi
	esac
;;
esac
