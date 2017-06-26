#!/usr/local/bin/bash

sh_keys=( "my_app.pem" "my_app2.pem" )
sh_bastion_key='bastion3ops.pem'

function sh_addkeys {
	echo "--- ADD KEYS ---"
	cd ~/.ssh
	ssh-add -D
	for i in ${sh_keys[@]}
	do
		ssh-add $i
	done
}

function sh_bastion {
	echo "--- SSH TO BASTION ---"
	sh_addkeys
	if [ -z "$1" ]; then
		ssh -Ai $sh_bastion_key ubuntu@bastion.ops
	else
		ssh -Ai $sh_bastion_key ubuntu@bastion.ops -t "$1"
	fi
}

function sh_app {
	echo "--- SSH TO APP ---"
	if [ -z $1 ]; then
		echo "Please specify app number"
	else
		sh_bastion "ssh app$1.production"
	fi
}

function sh_stage {
	echo "--- SSH TO APP ---"
	if [ -z $1 ]; then
		echo "Please specify app number"
	else
		sh_bastion "ssh app$1.stage"
	fi
}


function sh_db {
	echo "--- SSH TO APP ---"
	if [ -z $1 ]; then
		sh_bastion "ssh db.production"
	else
		sh_bastion "ssh db$1.production"
	fi
}

function sh_build {
	echo "--- SSH TO APP ---"
	sh_bastion "ssh build2.ops"
}

function sh_console {
	echo "--- RUN APP CONSOLE ---"
	if [ -z $1 ]; then
		echo "Please specify app number"
	else
		sub_command="sudo su -l vagrant -c 'cd /var/my_appapp/current; bundle exec rails c production'"
		sh_bastion "ssh app$1.production -t \"$sub_command\""
	fi
}
