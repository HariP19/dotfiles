#       _ _
#      | (_)
#  __ _| |_  __ _ ___
# / _` | | |/ _` / __|
#| (_| | | | (_| \__ \
# \__,_|_|_|\__,_|___/
#

# File Management and Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
mkcd() { mkdir -p "$@" && cd "$@"; }

alias ros_ws="cd /home/hari/Workspace/ros_ws"
alias test_ws="cd /home/hari/Workspace/test_ws"

alias Downloads="cd /home/hari/Downloads/"
alias Documents="cd /home/hari/Documents/"

# Git commands
alias gstatus="git status"
alias glog="git log"
alias gadd="git add"
alias gcommit="git commit -m"
alias gclone="git clone"
alias gcheckout="git checkout"
alias gpush="git push"
alias gpull="git pull"
alias gitlg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Get IP
alias ipaddress="echo $(ifconfig | grep broadcast | awk '{print $2}')"

# Sourcing 
alias ss='source ./devel/setup.bash' # source ROS workspace
alias sbash='source ~/.bashrc'

# Link ls with lsd
# Dependency - https://github.com/lsd-rs/lsd
function ls {
	command lsd "$@"
}

