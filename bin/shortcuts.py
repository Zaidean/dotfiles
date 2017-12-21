from pathlib import Path
# import csv
from re import sub
from re import compile

folders = (("h", "~"),
           ("d", "~/Documents"),
           ("D", "~/Downloads"),
           ("pp", "~/Pictures"),
           ("vv", "~/Videos"),
           ("m", "~/Music"),
           ("b", "~/Books"),
           ("s", "~/.dotfiles/"),
           ("r", "/"),
           ("cf", "~/.config"))

configs = (("cfz", "~/.zshrc"),
           ("cfe", "~/.emacs.d/init.el"),
           ("cfr", "~/.config/ranger/rc.conf"),
           ("cfq", "~/.config/qutebrowser/config.py"),
           ("cft", "~/.tmux.conf/"),
           ("cfd", "~/.Xresources"))



quteshortcuts = ""
rangershortcuts = ""
zshshortcuts = ""
home = str(Path.home())+"/"
rangerlocation=home+".dotfiles/ranger/rc.conf"
zshlocation=home+".dotfiles/zsh/aliases_zsh"
qutelocation=home+".dotfiles/qutebrowser/config.py"


# These are the labels that demarcate where the shortcuts
# go in the config files.
beg="# SHORTCUT START\n"
end="# SHORTCUT END"

#First we open the list of folder shortcuts and go down each line adding each in the required syntax to each of the three configs:

# with open(home+".config/Scripts/folders") as fold:
#     for line in csv.reader(fold, dialect="excel-tab"):
for fold in folders:
    #Adds the ranger go, tab, move and yank commands:
    rangershortcuts+=("map g"+fold[0]+" cd "+fold[1]+"\n")
    rangershortcuts+=("map t"+fold[0]+" tab_new "+fold[1]+"\n")
    rangershortcuts+=("map m"+fold[0]+" shell mv %s "+fold[1]+"\n")
    rangershortcuts+=("map Y"+fold[0]+" shell cp -r %s "+fold[1]+"\n")
    #Adds the bashshortcuts shortcuts:
    zshshortcuts+=("alias "+fold[0]+"=\"cd "+fold[1]+" && ls -a\"\n")
    #qutebrowser shortcuts:
    quteshortcuts+="config.bind(';"+fold[0]+"', 'set downloads.location.directory "+fold[1]+" ;; hint links download')\n"

#Goes thru the config file file and adds the shortcuts to both zshshortcuts and ranger.

for conf in configs:
    zshshortcuts+=("alias "+conf[0]+"=\emacsclient -nc -a \\\"\\\" "+conf[1]+"\"\n")
    rangershortcuts+=("map "+conf[0]+" shell emacsclient -nc -a \"\" "+conf[1]+"\n")


def replaceInMarkers(text, shortcuts):
    markers = compile(beg+"(.|\s)*"+end)
    replacement =beg+shortcuts+end
    return sub(markers, replacement, text)



def writeShortcuts(location, shortcuts):
    with open(location, "r+") as input:
        final = ""
        final += input.read()
        final = replaceInMarkers(final, shortcuts)
        input.seek(0)
        input.write(final)
        input.truncate()

writeShortcuts(rangerlocation, rangershortcuts)
writeShortcuts(zshlocation, zshshortcuts)
writeShortcuts(qutelocation, quteshortcuts)
