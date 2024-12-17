# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export EDITOR=$HOME/bin/e
export VISUAL=$HOME/bin/e
export ALTERNATE_EDITOR=$HOME/bin/e
export EMACS_TOOLKIT=x11

#https://serverfault.com/questions/376302/tigervnc-ssh-without-a-vnc-password
#echo "" | vncpasswd -f > $HOME/.vnc/passwd; x0vncserver -rfbauth $HOME/.vnc/passwd
#vncserver -alwaysshared -SecurityTypes None,TLSNone -geometry 3440x1387
# ~/bin/add-vnc-mode 3440x1387
# xrandr --output VNC-0 --mode 3440x1387

#vncconfig -display :13 -list

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# User specific aliases and functions

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

export GIT_MERGE_AUTOEDIT=no
export XZ_OPT="-0 --threads=4"
FIGNORE=.o:~:.bak:.swp

# Attempt at hyperlinking with delta
#rg ()
#{
#    $HOME/bin/rg --json "$@" | $HOME/bin/delta
#}

function delta_sidebyside {
    if [[ COLUMNS -ge 120 ]]; then
	DELTA_FEATURES='side-by-side'
    else
	DELTA_FEATURES=''
    fi
}
trap delta_sidebyside WINCH


# Add this lines at the top of .bashrc:
#[[ $- == *i* ]] && source ~/.local/share/blesh/ble.sh --noattach

eval "$(/tools_soc/opensrc/direnv/latest/bin/direnv hook bash)"

export LESSOPEN='|~/bin/lesspipe.bash %s'

# Prevent $ expansion
shopt -s direxpand

######### Powerline start ###########


# https://www.baeldung.com/linux/powerline-installation-configuration
if [ -f /usr/local/bin/powerline-daemon ]; then
    POWERLINE_BIN=/usr/local/bin
elif [ -f $HOME/.local/bin/powerline-daemon ]; then
    POWERLINE_BIN=$HOME/.local/bin
    PATH=$PATH:$HOME/.local/bin
fi

#mkdir /home/gczajkowski/.local/lib/python3.11/site-packages/scripts
#ln -sf /home/gczajkowski/.local/bin/powerline-config  /home/gczajkowski/.local/lib/python3.11/site-packages/scripts/
# mkdir -p /home/gczajkowski/.local/lib/python3.9/site-packages/powerline_exectime/bindings/bash
# wget -o /home/gczajkowski/.local/lib/python3.11/site-packages/powerline_exectime/bindings/bash/powerline-exectime.sh https://raw.githubusercontent.com/Rongronggg9/powerline-exectime/refs/heads/main/bindings/bash/powerline-exectime.sh
#/home/gczajkowski/.local/bin/pip3 install -U git+https://github.com/Rongronggg9/powerline-exectime --force-reinstall
#/home/gczajkowski/.local/bin/pip3.11 install -U git+https://github.com/Rongronggg9/powerline-exectime --force-reinstall
#/home/gczajkowski/.local/bin/pip3.11 install powerline-mem-segment
#cp ~/.local/lib/python3.11/site-packages/powerline/config_files/colorschemes/default.json $HOME/.config/powerline/colorschemes/default.json

if [ -f /usr/lib/python3.11/site-packages/powerline/bindings/bash/powerline.sh ]; then
    PYTHON_SITE_PACKAGES=/usr/lib/python3.11/site-packages
elif [ -f $HOME/.local/lib/python3.11/site-packages/powerline/bindings/bash/powerline.sh ]; then
    PYTHON_SITE_PACKAGES=$HOME/.local/lib/python3.11/site-packages
elif [ -f /usr/lib/python3.9/site-packages/powerline/bindings/bash/powerline.sh ]; then
    PYTHON_SITE_PACKAGES=/usr/lib/python3.9/site-packages
elif [ -f $HOME/.local/lib/python3.9/site-packages/powerline/bindings/bash/powerline.sh ]; then
    export LD_LIBRARY_PATH=/tools_soc/opensrc/python/python-3.9.18/lib:$LD_LIBRARY_PATH
    PYTHON_SITE_PACKAGES=$HOME/.local/lib/python3.9/site-packages
fi

echo $PYTHON_SITE_PACKAGES/powerline/bindings/bash/powerline.sh
echo $PYTHON_SITE_PACKAGES/powerline_exectime/bindings/bash/powerline-exectime.sh
echo POWERLINE_BIN=$POWERLINE_BIN

# /usr/bin/python3.11 $HOME/.local/bin/powerline-daemon --replace
# https://github.com/Rongronggg9/powerline-exectime
# Bash5
# _POWERLINE_EXECTIME_TIMER_START="${EPOCHREALTIME/[^0-9]/}"
# Bash4
_POWERLINE_EXECTIME_TIMER_START="$(date +%s%N)"
#echo  _POWERLINE_EXECTIME_TIMER_START=$_POWERLINE_EXECTIME_TIMER_START

if ! pgrep -x "powerline-daemon" > /dev/null; then
    # If not running, start powerline-daemon
    $POWERLINE_BIN/powerline-daemon -q
else
    echo $POWERLINE_BIN/powerline-daemon --replace
fi
export POWERLINE_BASH_CONTINUATION=1
export POWERLINE_BASH_SELECT=1
#export POWERLINE_CONFIG_COMMAND=$PYTHON_SITE_PACKAGES/scripts/powerline-config

source $PYTHON_SITE_PACKAGES/powerline/bindings/bash/powerline.sh
source $PYTHON_SITE_PACKAGES/powerline_exectime/bindings/bash/powerline-exectime.sh

# Restart with
# python3.11 $HOME/.local/bin/powerline-daemon --replace
# Lint with
# python3.9 $HOME/.local/bin/powerline-lint
######### Powerline end ###########

# Bash Completion
bind -f ~/.inputrc

source /tools_soc/tt/bin/bashrc

# enable bash git completion in interactive shells
if ! shopt -oq posix; then
  if [ -d /usr/share/bash-completions/completions ]; then    
    for file in /usr/share/bash-completion/completions/*; do
	# these files use 'have' which doesn't exist on SLES12
	[ -r "$file" ] && [ -f "$file" ] && . "$file"
    done
  fi

  # source these competion files for better bash tab completion
  if [ -d /etc/bash_completion.d ]; then
      for file in /etc/bash_completion.d/*; do
	  # these files use 'have' which doesn't exist on SLES12
	  [ -r "$file" ] && [ -f "$file" ] && . "$file"
      done
  fi
  if [ -d $HOME/.bash_completion.d ]; then
      for file in $HOME/.bash_completion.d/*; do
	  [ -r "$file" ] && [ -f "$file" ] && . "$file"
      done
  fi
fi

source /tools_soc/tt/Modules/init/profile.sh
module load rust
module load kitty

### Start of BASH_IT ###

# Path to the bash it configuration
export BASH_IT="/home/$USER/.bash_it"

# Lock and Load a custom theme file.
# Leave empty to disable theming.
# location /.bash_it/themes/
export BASH_IT_THEME='bobby'

# Some themes can show whether `sudo` has a current token or not.
# Set `$THEME_CHECK_SUDO` to `true` to check every prompt:
#THEME_CHECK_SUDO='true'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# (Advanced): Change this to the name of the main development branch if
# you renamed it or if it was changed for some reason
# export BASH_IT_DEVELOPMENT_BRANCH='master'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to the location of your work or project folders
#BASH_IT_PROJECT_PATHS="${HOME}/Projects:/Volumes/work/src"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true
# Set to actual location of gitstatus directory if installed
#export SCM_GIT_GITSTATUS_DIR="$HOME/gitstatus"
# per default gitstatus uses 2 times as many threads as CPU cores, you can change this here if you must
#export GITSTATUS_NUM_THREADS=8

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
# Will otherwise fall back on $USER.
#export SHORT_USER=${USER:0:8}

# If your theme use command duration, uncomment this to
# enable display of last command duration.
#export BASH_IT_COMMAND_DURATION=true
# You can choose the minimum time in seconds before
# command duration is displayed.
#export COMMAND_DURATION_MIN_SECONDS=1

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
#export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Uncomment this to make Bash-it create alias reload.
# export BASH_IT_RELOAD_LEGACY=1

# Load Bash It
#source "$BASH_IT"/bash_it.sh
#unalias l

#[[ ! ${BLE_VERSION-} ]] || ble-attach

# Homebrew
#eval "$(/opt/linuxbrew/.linuxbrew/bin/brew shellenv)"

# De-duplicate PATH and remove non-existant paths
PATH="$(python3 -c "import os,sys; print(':'.join(dict.fromkeys(filter(os.path.exists,map(os.path.normpath, os.environ['PATH'].split(':')))).keys()))")"
echo PATH=$PATH

[[ -f ~/.aliases ]] && source ~/.aliases

# Bash pre-exec for atuin https://github.com/rcaloras/bash-preexec
[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

# Bash LS_COLORS: https://github.com/trapd00r/LS_COLORS
[[ -f ~/LS_COLORS/lscolors.sh ]] && source ~/LS_COLORS/lscolors.sh

# Local config
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local

# Atuin https://docs.atuin.sh/guide/installation/
# Bind both ctrl-r and up arrow
#eval "$(/tools_soc/opensrc/rust/latest/bin/atuin init bash)"
#
# Bind ctrl-r but not up arrow
eval "$(/tools_soc/opensrc/rust/latest/bin/atuin init bash --disable-up-arrow)"

# Bind up-arrow but not ctrl-r
#eval "$(/tools_soc/opensrc/rust/latest/bin/atuin init bash --disable-ctrl-r)"

eval "$(/tools_soc/opensrc/rust/latest/bin/zoxide init bash)"

