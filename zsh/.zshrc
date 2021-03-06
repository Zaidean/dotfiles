#! /usr/bin/zsh
# ~/.zshrc
#
#==============================================================
#
# C O N F I G U R A T I O N  F O R  Z S H
#

#=-=-=-=-=-=-=
# load stuffs
#=-=-=-=-=-=-=

autoload -U colors && colors
autoload -U compinit && compinit
autoload -U vcs_info && vcs_info
autoload -U add-zsh-hook  #Adds precmd preexec etc. hooks
autoload -U promptinit && promptinit


zmodload zsh/complist
zmodload zsh/terminfo

# setopt
setopt \
    autocd \
    extendedglob \
    prompt_subst \
    inc_append_history \
    completealiases \
    hist_ignore_all_dups \
    correct \
    prompt_subst

# unsetopt
# unsetopt \


typeset -g -A key

key[Home]="$terminfo[khome]"
key[End]="$terminfo[kend]"
key[Insert]="$terminfo[kich1]"
key[Backspace]="$terminfo[kbs]"
key[Delete]="$terminfo[kdch1]"
key[Up]="$terminfo[kcuu1]"
key[Down]="$terminfo[kcud1]"
key[Left]="$terminfo[kcub1]"
key[Right]="$terminfo[kcuf1]"
key[PageUp]="$terminfo[kpp]"
key[PageDown]="$terminfo[knp]"

[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
[[ -n ${key[Insert]}    ]] && bindkey "${key[Insert]}"    overwrite-mode
[[ -n ${key[Home]}      ]] && bindkey "${key[Home]}"      beginning-of-line
[[ -n ${key[PageUp]}    ]] && bindkey "${key[PageUp]}"    up-line-or-history
[[ -n ${key[Delete]}    ]] && bindkey "${key[Delete]}"    delete-char
[[ -n ${key[End]}       ]] && bindkey "${key[End]}"       end-of-line
[[ -n ${key[PageDown]}  ]] && bindkey "${key[PageDown]}"  down-line-or-history
[[ -n ${key[Up]}        ]] && bindkey "${key[Up]}"        up-line-or-search
[[ -n ${key[Left]}      ]] && bindkey "${key[Left]}"      backward-char
[[ -n ${key[Down]}      ]] && bindkey "${key[Down]}"      down-line-or-search
[[ -n ${key[Right]}     ]] && bindkey "${key[Right]}"     forward-char

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi


if [ -n "$INSIDE_EMACS" ]; then
  chpwd() { print -P "\033AnSiTc %d" }
  print -P "\033AnSiTu %n"
  print -P "\033AnSiTc %d"
fi

source $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval $( dircolors -b $HOME/.config/zsh/ls_colors )
export LS_COLORS

(cat $HOME/.cache/wal/sequences &)
source $HOME/.cache/wal/colors.sh

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Import seperate config files
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

for r in $HOME/.config/zsh/*.zsh; do
  if [[ $DEBUG > 0 ]]; then
    echo "zsh: sourcing $r"
  fi
  source $r
done
