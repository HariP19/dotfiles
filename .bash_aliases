
#       _ _
#      | (_)
#  __ _| |_  __ _ ___
# / _` | | |/ _` / __|
#| (_| | | | (_| \__ \
# \__,_|_|_|\__,_|___/
#

# No more cd ../../../..
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# mkdir + cd 
mkcd() { mkdir -p "$@" && cd "$@"; }

# Update and Upgrade Packages 
alias udpate='sudo apt update && sudo apt upgrade'

# Quick access to git commands
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gco='git checkout'
alias gitlg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gb='git branch'
alias gpl='git pull'

# Sourcing 
alias ss='source ./devel/setup.bash'
alias sbash='source ~/.bashrc'

# Find the process ID for a specific program
alias findpid='ps aux | grep'

# Find files containing a a specific files
alias grepfile='grep -r --include="*.*"'

# Network-related
alias ifconfig='ip -c a'
alias pingg='ping 8.8.8.8'

# System monitoring and resource usage
alias mem='free -h'
alias cpu='lscpu'
alias topmem='top -o %MEM'
alias topcpu='top -o %CPU'

# Disk usage and management
alias df='df -h'
alias du='du -h'
alias dus='du -sh'

# MISC
alias mkdir='mkdir -p'
alias now='date +"%T"'
alias today='date +"%d-%m-%Y"'
alias rm='rm -i'
alias screen-saver='while [ TRUE ]; do head -n 100 /dev/urandom; sleep .1; done | hexdump -C | grep "ca fe"'

#
# THIRD-PARTY
#
# Remap ls with lsd
# Dependency - https://github.com/lsd-rs/lsd
if command -v lsd >/dev/null 2>&1; then # Check if lsd is installed
	function ls {
		command lsd "$@"
	}
fi
