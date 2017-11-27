#colorize command line with username & hostname
HOST=something
export PS1='\[\e[0;32m\]\u@\e[0;34m${HOST}:\e[0;33m\w \e[0;32m[\t]\$\[\e[0m\]'
