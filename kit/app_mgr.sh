coffee='node_modules/.bin/coffee'
forever='node_modules/.bin/forever'

app=$(pwd)/nobone.coffee

case $1 in
	'setup' )
		# Dependencies
			npm install
			node_modules/.bin/bower --allow-root install

		# Configuration
		config_example='kit/config.example.coffee'
		if [ ! -f config.coffee ]; then
			echo '>> Auto created an example config file.'
			cp $config_example var/config.coffee
		fi

		groupadd guest
		mkdir /home/guest
		;;

	'test' )
		$coffee --nodejs --debug $app
		;;

	'start' )
		uptime_conf='--minUptime 5000 --spinSleepTime 5000'
		log_conf='-a -o var/log/std.log -e var/log/err.log'
		$forever start $uptime_conf $log_conf -c $coffee $app
		;;

	'stop' )
		$forever stop $app
		;;
esac