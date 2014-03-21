#!/bin/zsh

username=$1
password=$2
group=guest

if [[ -n $(getent passwd $username) ]]; then
	printf 'exists'
	exit
fi

useradd -m -s /bin/zsh -g "$group" -d "/home/$group/$username" "$username"
printf "$password\n$password" | passwd -q "$username"
printf 'ok'
