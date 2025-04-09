# .bashrc
# shellcheck shell=bash

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

TT_OS="$(/tools_soc/tt/ttonboarding/stable/bin/tt-os.bash)"
if [ "$TT_OS" = "rhel-8.10" ]; then
    echo "OS: $TT_OS"
else
    echo "OS: $TT_OS"
fi

# Editor setup
export EDITOR=$HOME/bin/e
export VISUAL=$HOME/bin/e
export ALTERNATE_EDITOR=$HOME/bin/e
export EMACS_TOOLKIT=x11

# Search tool setup
export RIPGREP_CONFIG_PATH=~/.ripgreprc

# Pager setup
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
#export MANPAGER="ov --section-delimiter '^[^\s]' --section-header" # https://noborus.github.io/ov/man/index.html
unset BAT_PAGER
#export BAT_PAGER="ov -F -H3 --view-mode bat" # https://noborus.github.io/ov/bat/index.html
export MANROFFOPT="-c"
export DELTA_PAGER='less -rFX'
export LESSOPEN='|~/bin/lesspipe.bash %s'
export LESS='-rFX'

function delta_sidebyside {
    if [[ $COLUMNS -ge 120 ]]; then
        export DELTA_FEATURES='side-by-side'
    else
        export DELTA_FEATURES=''
    fi
}
trap delta_sidebyside WINCH

# Git setup
export GIT_MERGE_AUTOEDIT=no
FIGNORE=.o:~:.bak:.swp

# Compressor setup
export XZ_OPT="-0 --threads=4"

#https://serverfault.com/questions/376302/tigervnc-ssh-without-a-vnc-password
#echo "" | vncpasswd -f > $HOME/.vnc/passwd; x0vncserver -rfbauth $HOME/.vnc/passwd
#vncserver -alwaysshared -SecurityTypes None,TLSNone -geometry 3440x1387
# ~/bin/add-vnc-mode 3440x1387
# xrandr --output VNC-0 --mode 3440x1387

#vncconfig -display :13 -list

# Attempt at hyperlinking with delta
#rg ()
#{
#    $HOME/bin/rg --json "$@" | $HOME/bin/delta
#}

# Add this lines at the top of .bashrc:
#[[ $- == *i* ]] && source ~/.local/share/blesh/ble.sh --noattach

# Prevent $ expansion
shopt -s direxpand

#-----------------------------------------------# Powerline end #----------------------------------------------- #

# https://www.baeldung.com/linux/powerline-installation-configuration
if [ -f "$HOME/.local/bin/powerline-daemon" ]; then
    POWERLINE_BIN=$HOME/.local/bin
elif [ -f /usr/local/bin/powerline-daemon ]; then
    POWERLINE_BIN=/usr/local/bin
elif [ -f /tools_soc/opensrc/python/python-3.9.18/bin/powerline-daemon ]; then
    POWERLINE_BIN=/tools_soc/opensrc/python/python-3.9.18/bin
fi

PATH=$PATH:$POWERLINE_BIN

#mkdir /home/gczajkowski/.local/lib/python3.11/site-packages/scripts
#ln -sf /home/gczajkowski/.local/bin/powerline-config  /home/gczajkowski/.local/lib/python3.11/site-packages/scripts/
# mkdir -p /home/gczajkowski/.local/lib/python3.9/site-packages/powerline_exectime/bindings/bash
# wget -o /home/gczajkowski/.local/lib/python3.11/site-packages/powerline_exectime/bindings/bash/powerline-exectime.sh https://raw.githubusercontent.com/Rongronggg9/powerline-exectime/refs/heads/main/bindings/bash/powerline-exectime.sh
# sudo /tools_soc/opensrc/python/python-3.9.18/bin/pip3.9 install -U powerline-status --force-reinstall
#/home/gczajkowski/.local/bin/pip3 install -U git+https://github.com/Rongronggg9/powerline-exectime --force-reinstall
#/home/gczajkowski/.local/bin/pip3.11 install -U git+https://github.com/Rongronggg9/powerline-exectime --force-reinstall
#/home/gczajkowski/.local/bin/pip3.11 install powerline-mem-segment
#pip3.12 pip install powerline-gitstatus
#cp ~/.local/lib/python3.11/site-packages/powerline/config_files/colorschemes/default.json $HOME/.config/powerline/colorschemes/default.json

if which python3.12 > /dev/null 2>&1 && [ -f "$HOME/.local/lib/python3.12/site-packages/powerline/bindings/bash/powerline.sh" ]; then
    PYTHON_SITE_PACKAGES="$HOME/.local/lib/python3.12/site-packages"
    POWERLINE_PYTHON=python3.12
#    export POWERLINE_CONFIG_COMMAND="$POWERLINE_PYTHON $PYTHON_SITE_PACKAGES/scripts/powerline-config"    
elif which python3.12 > /dev/null 2>&1 && [ -f "/usr/lib/python3.12/site-packages/powerline/bindings/bash/powerline.sh" ]; then
    PYTHON_SITE_PACKAGES=/usr/lib/python3.12/site-packages
    POWERLINE_PYTHON=python3.12
#    export POWERLINE_CONFIG_COMMAND="$POWERLINE_PYTHON $PYTHON_SITE_PACKAGES/scripts/powerline-config"    
elif which python3.11 > /dev/null 2>&1 && [ -f "$HOME/.local/lib/python3.11/site-packages/powerline/bindings/bash/powerline.sh" ]; then
    PYTHON_SITE_PACKAGES="$HOME/.local/lib/python3.11/site-packages"
    POWERLINE_PYTHON=python3.11
#    export POWERLINE_CONFIG_COMMAND="$POWERLINE_PYTHON $PYTHON_SITE_PACKAGES/scripts/powerline-config"
elif which python3.11 > /dev/null 2>&1 && [ -f "/usr/lib/python3.11/site-packages/powerline/bindings/bash/powerline.sh" ]; then
    PYTHON_SITE_PACKAGES=/usr/lib/python3.11/site-packages
    POWERLINE_PYTHON=python3.11
#    export POWERLINE_CONFIG_COMMAND="$POWERLINE_PYTHON $PYTHON_SITE_PACKAGES/scripts/powerline-config"    
elif [ -f "/tools_soc/opensrc/python/python-3.9.18/lib/python3.9/site-packages/powerline/bindings/bash/powerline.sh" ]; then
    PYTHON_SITE_PACKAGES=/tools_soc/opensrc/python/python-3.9.18/lib/python3.9/site-packages
    POWERLINE_PYTHON=/tools_soc/opensrc/python/python-3.9.18/bin/python3
#    export POWERLINE_CONFIG_COMMAND="$POWERLINE_PYTHON $HOME/.local/bin/powerline-config"    
elif which python3.9 > /dev/null 2>&1 && [ -f "$HOME/.local/lib/python3.9/site-packages/powerline/bindings/bash/powerline.sh" ]; then
    POWERLINE_PYTHON=python3.9
    PYTHON_SITE_PACKAGES="$HOME/.local/lib/python3.9/site-packages"
#    export POWERLINE_CONFIG_COMMAND="$POWERLINE_PYTHON $HOME/.local/bin/powerline-config"
elif which python3.9 > /dev/null 2>&1 && [ -f "/usr/lib/python3.9/site-packages/powerline/bindings/bash/powerline.sh" ]; then
    PYTHON_SITE_PACKAGES="/usr/lib/python3.9/site-packages"
    POWERLINE_PYTHON=python3.9
#    export POWERLINE_CONFIG_COMMAND="$POWERLINE_PYTHON /usr/bin/powerline-config"    
fi

echo "POWERLINE_SH=$PYTHON_SITE_PACKAGES/powerline/bindings/bash/powerline.sh"
echo "POWERLINE_EXECTIME_SH=$PYTHON_SITE_PACKAGES/powerline_exectime/bindings/bash/powerline-exectime.sh"
echo "POWERLINE_BIN=$POWERLINE_BIN"


# $POWERLINE_PYTHON $HOME/.local/bin/powerline-daemon --replace

# https://github.com/Rongronggg9/powerline-exectime
# Bash5
# _POWERLINE_EXECTIME_TIMER_START="${EPOCHREALTIME/[^0-9]/}"
# Bash4
_POWERLINE_EXECTIME_TIMER_START="$(date +%s%N)"
#echo  _POWERLINE_EXECTIME_TIMER_START=$_POWERLINE_EXECTIME_TIMER_START

#set -x

if ! ps -f -u "$USER" | grep "[p]owerline-daemon" > /dev/null; then
    echo "$POWERLINE_PYTHON" "$POWERLINE_BIN/powerline-daemon" -q
    "$POWERLINE_PYTHON" "$POWERLINE_BIN/powerline-daemon" -q
else
    echo "$POWERLINE_PYTHON $POWERLINE_BIN/powerline-daemon --replace"
fi
export POWERLINE_BASH_CONTINUATION=1
export POWERLINE_BASH_SELECT=1

# shellcheck source=/tools_soc/opensrc/python/python-3.9.18/lib/python3.9/site-packages/powerline/bindings/bash/powerline.sh
. "$PYTHON_SITE_PACKAGES/powerline/bindings/bash/powerline.sh"

# shellcheck source=/tools_soc/opensrc/python/python-3.9.18/lib/python3.9/site-packages/powerline_exectime/bindings/bash/powerline-exectime.sh
. "$PYTHON_SITE_PACKAGES/powerline_exectime/bindings/bash/powerline-exectime.sh"

#set +x

# Restart with
# python3.12 $HOME/.local/bin/powerline-daemon --replace
# python3.11 $HOME/.local/bin/powerline-daemon --replace
# Lint with
# python3.9 $HOME/.local/bin/powerline-lint

# per default gitstatus uses 2 times as many threads as CPU cores, you can change this here if you must
export GITSTATUS_NUM_THREADS=8

#-----------------------------------------------# Powerline end #----------------------------------------------- #

# Keymap
bind -f ~/.inputrc
source /tools_soc/tt/Modules/init/profile.sh
module list
source /tools_soc/tt/bin/bashrc

eval "$(/tools_soc/opensrc/direnv/stable/bin/direnv hook bash)"

# Sourced by source /tools_soc/tt/bin/bashrc
#source /tools_soc/tt/Modules/init/profile.sh

# Homebrew
#eval "$(/opt/linuxbrew/.linuxbrew/bin/brew shellenv)"

# User specific aliases and functions

# shellcheck source=SCRIPTDIR/.aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Bash pre-exec for atuin https://github.com/rcaloras/bash-preexec
# shellcheck source=SCRIPTDIR/.bash-preexec.sh
[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

# Bash LS_COLORS: https://github.com/trapd00r/LS_COLORS
# shellcheck source=SCRIPTDIR/LS_COLORS/lscolors.sh
[[ -f ~/LS_COLORS/lscolors.sh ]] && source ~/LS_COLORS/lscolors.sh

# Local config
# shellcheck source=SCRIPTDIR/.bashrc.local
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local

if ! shopt -oq posix; then
    if [ -d "$HOME/.bash_completion.d" ]; then
        for file in "$HOME"/.bash_completion.d/*; do
            # shellcheck disable=SC1090
	    [ -r "$file" ] && [ -f "$file" ] && . "$file"
        done
    fi
fi

if [ "$TT_OS" = "rhel-8.10" ]; then

    # Bash Completion
    # enable bash git completion in interactive shells
    if ! shopt -oq posix; then
        # source these competion files for better bash tab completion
        if [ -d /etc/bash_completion.d ]; then
            for file in /etc/bash_completion.d/*; do
	        # these files use 'have' which doesn't exist on SLES12, CentOS7
                # shellcheck disable=SC1090
	        [ -r "$file" ] && [ -f "$file" ] && . "$file"
            done
        fi
        #if [ -d /usr/share/bash-completion/completions ]; then
        #    for file in /usr/share/bash-completion/completions/*; do
	#        # these files use 'have' which doesn't exist on SLES12, CentOS7, RH8
        #        # shellcheck disable=SC1090
	#        [ -r "$file" ] && [ -f "$file" ] && . "$file"
        #    done
        #fi
    fi

    #module load autocutsel
    module load direnv # For VSCode extension
    module load kitty
    module load go
    module load fzf
    module load shellcheck
    module load rust

    # shellcheck source=/dev/null
    source <(procs --gen-completion-out bash)

    export FZF_DEFAULT_COMMAND='fd --type f'
    #export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"
    export FZF_DEFAULT_OPTS="--style full --preview 'fzf-preview.sh {}' --bind 'focus:transform-header:file --brief {}' --preview-window=right:60%"
    eval "$(/tools_soc/opensrc/fzf/stable/fzf --bash)"

    # Atuin https://docs.atuin.sh/guide/installation/
    # Bind both ctrl-r and up arrow
    #eval "$(/tools_soc/opensrc/rust/stable/bin/atuin init bash)"
    #
    # Bind ctrl-r but not up arrow
    eval "$(/tools_soc/opensrc/rust/stable/bin/atuin init bash --disable-up-arrow)"
    #eval "$(/tools_soc/opensrc/rust/stable/bin/atuin init bash)"
    #bind -x '"\e[A": __atuin_history --shell-up-key-binding'

    # Bind up-arrow but not ctrl-r
    #eval "$(/tools_soc/opensrc/rust/stable/bin/atuin init bash --disable-ctrl-r)"

    eval "$(/tools_soc/opensrc/rust/stable/bin/zoxide init bash)"
else
    /bin/true
fi

module swap python/3.9.18

# User specific environment at the front
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# De-duplicate PATH and remove non-existant paths
PYTHON=$(which python3 2>/dev/null || which3 python 2>/dev/null) || (echo "Error: No 'python' or 'python3' interpreter found!" && exit)
PATH="$($PYTHON -c "import os,sys; print(':'.join(dict.fromkeys(filter(os.path.exists,map(os.path.normpath, os.environ['PATH'].split(':')))).keys()))")"
echo "PATH=$PATH"

export NO_AT_BRIDGE=1
