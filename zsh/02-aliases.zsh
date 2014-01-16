alias hdmi='xrandr --output HDMI1 --auto --left-of LVDS'
alias pres='xrandr --fb 1366x768 --output DP2 --mode 1024x768 --panning 1366x0'
alias mon='xrandr --output DP2 --mode 1680x1050 --left-of eDP1
# feh --bg-fill $HOME/.wallpaper/current.jpg'
alias update='yaourt -Syua --noconfirm'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias e='emacs'
alias shu='systemctl poweroff'
alias re='sudo reboot'
alias wd='sudo ifconfig wlan0 down'
alias wu='sudo ifconfig wlan0 up'
alias install='sudo yaourt -S'
alias uninstall='sudo yaourt -Rns'
alias search='sudo yaourt -Ss'
alias clean='sudo pacman -Rns $(pkg-list_true_orphans)'
# alias ps='ps -a -c -o pid,command -x'

# grep
grephistory()
{
    grep $1 $HOME/.dotfiles/zsh/history.log
}
alias his='grephistory'
