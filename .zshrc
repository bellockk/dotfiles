# Printer setup
# >> sudo dnf -y install cups-bjnp
# >> Printers:  Add Printer
# >> Canon: bjnp://192.168.2.123:8611
# >> Select Driver
#Color table from: http://www.understudy.net/custom.html
fg_black=%{$'\e[0;30m'%}
fg_red=%{$'\e[0;31m'%}
fg_green=%{$'\e[0;32m'%}
fg_brown=%{$'\e[0;33m'%}
fg_blue=%{$'\e[0;34m'%}
fg_purple=%{$'\e[0;35m'%}
fg_cyan=%{$'\e[0;36m'%}
fg_lgray=%{$'\e[0;37m'%}
fg_dgray=%{$'\e[1;30m'%}
fg_lred=%{$'\e[1;31m'%}
fg_lgreen=%{$'\e[1;32m'%}
fg_yellow=%{$'\e[1;33m'%}
fg_lblue=%{$'\e[1;34m'%}
fg_pink=%{$'\e[1;35m'%}
fg_lcyan=%{$'\e[1;36m'%}
fg_white=%{$'\e[1;37m'%}
#Text Background Colors
bg_red=%{$'\e[0;41m'%}
bg_green=%{$'\e[0;42m'%}
bg_brown=%{$'\e[0;43m'%}
bg_blue=%{$'\e[0;44m'%}
bg_purple=%{$'\e[0;45m'%}
bg_cyan=%{$'\e[0;46m'%}
bg_gray=%{$'\e[0;47m'%}
#Attributes
at_normal=%{$'\e[0m'%}
at_bold=%{$'\e[1m'%}
at_italics=%{$'\e[3m'%}
at_underl=%{$'\e[4m'%}
at_blink=%{$'\e[5m'%}
at_outline=%{$'\e[6m'%}
at_reverse=%{$'\e[7m'%}
at_nondisp=%{$'\e[8m'%}
at_strike=%{$'\e[9m'%}
at_boldoff=%{$'\e[22m'%}
at_italicsoff=%{$'\e[23m'%}
at_underloff=%{$'\e[24m'%}
at_blinkoff=%{$'\e[25m'%}
at_reverseoff=%{$'\e[27m'%}
at_strikeoff=%{$'\e[29m'%}
# 
# 
# Remove anoying delete confirmation when using rm -rf
setopt rmstarsilent
setopt prompt_subst
function zrcautoload() {
    emulate -L zsh
    setopt extended_glob
    local fdir ffile
    local -i ffound

    ffile=$1
    (( found = 0 )) 
    for fdir in ${fpath} ; do 
        [[ -e ${fdir}/${ffile} ]] && (( ffound = 1 )) 
    done 

    (( ffound == 0 )) && return 1
    if [[ $ZSH_VERSION == 3.1.<6-> || $ZSH_VERSION == <4->* ]] ; then 
        autoload -U ${ffile} || return 1
    else 
        autoload ${ffile} || return 1
    fi
    return 0
}
zrcautoload vcs_info || vcs_info() {return 1}
zstyle ':vcs_info:*' actionformats \
        '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
        '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git cvs svn hg

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}

PROMPT=$'
${fg_lgreen}%n@${at_underl}%m${at_underloff}${fg_red}[${fg_cyan}%~${fg_red}] $(vcs_info_wrapper)
[${fg_green}%T${fg_red}]:${at_normal} Yes Master... '
#Set the auto completion on
autoload -U compinit
compinit
# 
#Lets set some options
setopt correctall
setopt autocd
setopt auto_resume
#     
# Enables the extgended globbing features
setopt extendedglob
#      
#Set some ZSH styles
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
# 
HISTFILE=~/.zsh-histfile
HISTSIZE=100000
SAVEHIST=100000
#        
#Aliases
#ls, the common ones I use a lot shortened for rapid fire usage
alias ls='ls --color' #I like color
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable

#RSYNC Aliases
alias runbackup='sudo rsync -vrlptgo --delete /local/bellockk /run/media/bellockk/BellockBackup'
alias pullbackup='rsync -vrlptgo --delete --exclude Dropbox /run/media/bellockk/BellockBackup/bellockk /local'
alias pushbackup='rsync -vrlptgo --checksum --delete /local/bellockk /run/media/bellockk/BellockBackup'
alias backupmovies='rsync -av --delete /samba/media/Movies /run/media/bellockk/Bellock\ Backup\ II/Media/'
alias backuptvshows='rsync -av --delete /samba/media/TV-Shows /run/media/bellockk/Bellock\ Backup\ II/Media/'
alias runalexbackup='rsync -vrlptgo --exclude-from=/home/bellockk/.rsync/exclude --delete /data/bellocka /media/2ba3296f-aeb7-46bf-a873-09c207c7496c/data'
alias loadmovies='rsync -rlvzuP /home/bellockk/Downloads/*.mkv /samba/media/Movies/.'
alias superbackup='rsync -rlvu /samba/media /run/media/bellockk/Seagate\ Backup\ Plus\ Drive'

# Paths
if [[ -n "$WINDIR" ]]; then
    export PROCESSOR_ARCHITECTURE=AMD64
fi
export PATH=/bin:/usr/bin:/usr/local/bin:/sbin
export PATH=~/Development/AMT/bin:${PATH}
export PATH=~/local/bin:~/local/usr/bin:${PATH}
export PATH=/usr/local/MATLAB/R2015b/bin:${PATH}
export PATH=/opt/SweetHome3D:${PATH}
export PYTHONPATH=~/local/lib64/python
export EDITOR=vim

# Fix to stop gnome-ssh-askpass from annoying me.
unset SSH_ASKPASS

#VBOX Notes
# to get IP of running VM from VM name
# >> vboxmanage guestproperty get "Windows7-x86_64-VS2010" "/VirtualBox/GuestInfo/Net/0/V4/IP" | awk '{ print $2 }' 

# Uncomment the following line to get big core files
ulimit -c unlimited

# Human Readable Sort
# >> du -sh * | sort -rh
alias space_desktop='nohup livestreamer http://ustream.tv/channel/iss-hdev-payload mobile_480p --player "vlc --video-wallpaper --no-embedded-video --qt-start-minimized --qt-notification 0 --qt-system-tray" &'

# Turn On VM
# vboxmanage list vms
# vboxmanage list runningvms
alias startvms='ssh 192.168.2.51 "/usr/bin/vboxheadless -s Windows > /dev/null 2>&1 &"
alias stopvms='ssh 192.168.2.51 "/usr/bin/vboxmanage controlvm Windows savestate"
alias unetbootin='sudo QT_X11_NO_MITSHM=1 unetbootin'
alias dexit='disown -a && exit'

greptovim() {
    grep $1 -RIil . | grep -v ".git" | grep -v arch | grep -v delivery | grep -v contrib | xargs bash -c '</dev/tty vim "$@"' ignore
