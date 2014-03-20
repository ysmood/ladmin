#!/bin/zsh

username=$1
password=$2

if [[ -n $(getent passwd $username) ]]; then
	printf 'exists'
	exit
fi

useradd -m -s /bin/zsh "$username" -g student
printf "$password\n$password" | passwd -q $username
printf 'ok'
