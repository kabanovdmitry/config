source $HOME/apps/lmod/lmod/init/profile

source $HOME/.zplug/init.zsh

zplug "plugins/git", from:oh-my-zsh
zplug "themes/blinks", from:oh-my-zsh

zplug load

eval `dircolors $HOME/.dir_colors/dircolors`

# Aliases
alias -g L="| less"
alias -g LL="2>&1 | less"
alias -g C="| wc -l"
# ls arguments:
# -A --almost-all      do not list . and ..
# -h --human-readable  with -l, print sizes in human-readable format
# -F --classify        append indicator to entries to emphasize their type
alias ll='ls -lAhF'
alias zshconfig="vim ~/.zsh-customization"
alias zshrestart="source ~/.zshrc"
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias timepython='/usr/bin/time -p python'
alias posixtime='/usr/bin/time -p'

# Set environment variables.
export dev=~/Dropbox/dev
export notes=~/Documents/Notes
export EDITOR=vim
export BROWSER=google-chrome
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# ZSH options.
setopt extendedglob

man() {
    # Attributes are set using escape sequences starting with `\e[`.
    # Attributes codes can be found here:
    # http://www.termsys.demon.co.uk/vtansi.htm
    local mb=$(printf "\e[1;31m")   # Begin blinking.
    local md=$(printf "\e[1;31m")   # Begin bold.
    local me=$(printf "\e[0m")      # End mode.
    local so=$(printf "\e[7m")      # Begin standout mode.
    local se=$(printf "\e[0m")      # End standout mode.
    local us=$(printf "\e[4;32m")   # Begin underline.
    local ue=$(printf "\e[0m")      # End underline.
    env LESS_TERMCAP_mb=$mb \
        LESS_TERMCAP_md=$md \
        LESS_TERMCAP_me=$me \
        LESS_TERMCAP_so=$so \
        LESS_TERMCAP_se=$se \
        LESS_TERMCAP_us=$us \
        LESS_TERMCAP_ue=$ue \
        MANWIDTH=80 \
        man "$@"
}
