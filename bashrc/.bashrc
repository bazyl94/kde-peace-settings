# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#check if your silly $HOME/bin is in your path 
if [[ -d "$HOME/bin" && $PATH != *"$HOME/bin"*  ]] ; then
    export PATH=$PATH:$HOME/bin
elif [[ -d "$HOME/bin" ]] ; then 

    echo "Your PATH contains your $HOME/bin ..OK skipping "
else 
    echo "$HOME/bin do not exist.... skipping  "
fi 
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoredups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=3000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


function wgets()
{
  local H='--header'
  wget $H='Accept-Language: en-us,en;q=0.5' $H='Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' $H='Connection: keep-alive' -U 'Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20100101 Firefox/10.0.2' --referer=http://www.askapache.com/ "$@";
}

function tempwget()
{
cd /tmp
  local H='--header'
  wget $H='Accept-Language: en-us,en;q=0.5' $H='Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' $H='Connection: keep-alive' -U 'Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20100101 Firefox/10.0.2' --referer=http://www.askapache.com/ "$@";
}

function enelelettricita()
{
 cd Elettricita ;for file in *.pdf ; do a="$file" ;pdftotext "$a" - | awk '/Bolletta/ {for(i=1;i<=2; i++) {getline;  print}}' | awk '/€|¬/{gsub(/€|¬|kWh|\//,"") ;print $1}'| awk 'NF > 0'   ; done ; cd ..

}

function enelgas()
{
 cd gas ;for file in *.pdf ; do a="$file" ;pdftotext "$a" - | awk '/Bolletta/ {for(i=1;i<=2; i++) {getline;  print}}' | awk '/€|¬/{gsub(/€|¬|kWh|cliente|\//,"") ;print $1}'| awk 'NF > 0'   ; done ; cd ..

}

function enelhera()
{
cd Acqua ; for file in *.pdf ; do a="$file" ;  pdftotext "$a" - | awk '/Totale da pagare/{print $4}' ; done ; cd ..

}


# alias kdmnest="Xephyr -query localhost -screen 800x600 :1"
# #alias ="/home/shared/-01-28-13/./"
# #alias ffprobe="~/-02-15-12/./ffprobe"
# #alias peacecalc="a=$1 ; b=$2 ; c=$3 ; echo \"scale=3 ; $a $b $c\" | bc" 
# alias vrec="/home/shared/-01-28-13/./ -s video_size  $(xrandr  | awk '/, current /{print $8}')x$(xrandr  | awk '/, current /{gsub(/\,/,"");print $10}') -f x11grab -r 25  -i :0.0  -vcodec  ljpeg -threads 2 -y  $HOME/output.avi"
# alias vrecb="/home/shared/-01-28-13/./ -s $(xrandr  | awk '/, current /{print $8}')x$(xrandr  | awk '/, current /{gsub(/\,/,"");print $10}') -f x11grab -r 30  -i :0.0  -vcodec  ljpeg -threads 2 -y  $HOME/output.avi"
# alias tffm="/home/shared/-05-22-12/./"
# alias youconvert="/home/shared/-01-28-13/./ -i  \"$HOME/output.avi\" -sameq -threads 2 $HOME/output.webm"
# alias screncast="arecord -f cd -t raw | oggenc - -r -o $HOME/out_audio.ogg  &  -f x11grab  -s $(xrandr  | awk '/, current /{ gsub(/\,/,""); print $8"x"$10}') -i :0.0  -r 25 -threads $(awk '/processor/{print}' /proc/cpuinfo | wc -l) -y -vcodec ljpeg $HOME/out_video.avi"
# alias screncastb="  -f x11grab  -s $(xrandr  | awk '/, current /{ gsub(/\,/,""); print $8"x"$10}') -i :0.0  -r 25 -threads $(awk '/processor/{print}' /proc/cpuinfo | wc -l) -y -vcodec libtheora  -b 2000k  $HOME/out_video.ogv"
# alias ascreencast="arecord -f cd -t raw | oggenc - -r -o $HOME/out_audio.ogg"
# alias ascreencast="arecord -f cd -t raw | oggenc - -r -o $HOME/out_audio.ogg"
# alias screncast_stop="pkill --signal TERM oggenc & pkill --signal TERM  "
# 

alias ugf="sudo apt-get update ; sudo apt-get upgrade -y "
alias udgf="sudo apt-get update ; sudo apt-get dist-upgrade -y"
alias u="sudo apt-get update"
alias g="sudo apt-get upgrade"
alias uf="echo sudo apt-get upgrade -y  && sudo apt-get upgrade -y"
alias gf="sudo apt-get dist-upgrade -y"
alias i="sudo apt-get install -y "
alias ai="apt-cache show"
alias lfd="sudo apt-file update  && apt-file list "
alias li="dpkg --get-selections | grep -v deinstall"
alias ad="apt-cache depends"
alias r="sudo apt-get remove --auto-remove"
alias p="sudo apt-get --purge --auto-remove remove "
alias s="apt-cache search "
alias a="sudo apt-get autoremove"
alias save-apt-list="dpkg --get-selections | grep -v deinstall >$HOME/apt-list.lst ; echo saved on $HOME/apt-list.lst"
alias install-apt-list="sudo dpkg --set-selections < $HOME/apt-list.lst ; sudo apt-get -u dselect-upgrade"
alias remove-apt-lock="sudo  rm /var/lib/apt/lists/lock  ; sudo rm /var/lib/dpkg/lock "
alias wdc="apt-file find "
alias h="echo \"
u			#update repository list			sudo apt-get update
g			#upgrade				sudo apt-get upgrade
uf			#force upgrade				sudo apt-get upgrade -y
gf			#force dist-upgrade			sudo apt-get dist-upgrade -y
d			#dependences				apt-cache depends with awk 
i			#install packages			sudo apt-get install -y 
ai			#information about the package		apt-cache show
li			#list packages installed		dpkg --get-selections | grep -v deinstall
lfd                     #list file in a debian package          apt-file list package_name
wdc                     #which debian contains this file        apt-file find /my/file
r			#remove a package			sudo apt-get --auto-remove remove 
p			#remove a packate & conf file		sudo apt-get --purge --auto-remove remove
s			#search for a software			apt-cache search 
sn 			#search with only names 		apt-cache search --names-only
a			#autoremove a software			sudo apt-get autoremove

special ones :

ugf			#update and upgrade			sudo apt-get update ; sudo apt-get upgrade -y 
udgf			#uodate and dist-upgrade		sudo apt-get update ; sudo apt-get dist-upgrade -y 
ad			#dependences required by a package	apt-cache depends
alf			#files installed by a package 		apt-file list 
b			#block update for a package		apt-mark hold package_name
ub			#block update for a package		apt-mark unhold package_name


save-apt-list		#save list of packages installed	dpkg --get-selections | grep -v deinstall >$HOME/apt-list.lst
install-apt-list	#install a list of packages in		sudo dpkg --set-selections < $HOME/apt-list.lst ; sudo apt-get -u dselect-upgrade

remove-apt-lock 	#remove locks  when user kill apt :D	sudo  rm /var/lib/apt/lists/lock  ; sudo rm /var/lib/dpkg/lock

FORMAT 

format_to_fat32		#format to fat 32 format		sudo mkdosfs -F 32 -I \$1
format_to_btrfs		#format with force option to btrfs	sudo mkfs.btrfs -f \$1\"
"
 peacefun()
{
	cur=`_get_cword`
	COMPREPLY=( $( apt-cache pkgnames $cur 2> /dev/null ) )
	return 0
	
} 

# sn(){
# apt-cache search $1| cut -d " " -f 1
# }


sna(){

echo "apt-cache search $1"
apt-cache search $1| cut -d " " -f 1
 
 
}

alf(){

echo "apt-file list $1"
apt-file list $1 | cut -d " " -f 2 
 
 
}
d(){
apt-cache show "$1" | awk '/Depen/ || /Rec/{ gsub(/\,/,"") ;gsub(/Recommends:/,"");gsub(/Depends:/,""); print} ' | awk '{ printf "%s ", $0 }'
echo 
}
complete -F peacefun  ai
complete -F peacefun  lfd
complete -F peacefun  i 
complete -F peacefun  s 
complete -F peacefun  sn 
complete -F peacefun  p 
complete -F peacefun  r
complete -F peacefun  ad 
complete -F peacefun  d 
complete -F peacefun  alf 
complete -F peacefun  b 
complete -F peacefun  ub 


search_bashhistory(){
grep -i "$1" ~/.bash_history
}
conferencepulse()
{
#license gpl 
#copyright nowardev@gmail.com


i=0
while read line ;do
audiocard[$i]="$line"
i=$(($i+1))
done< <( grep capture /proc/asound/pcm | cut -b 2)

i=0
while read line ;do
audionamecard[$i]="$line"
i=$(($i+1))
done< <(grep capture /proc/asound/pcm | cut -d : -f 2)

 
if [[ ${#audiocard[@]} >1 ]]; then 
echo $"I have detected more than 1 microphone in your computer please select what you want use (0-$((${#audiocard[@]}-1)))
"

 
 
i=0
for (( i=0 ; i <${#audiocard[@]};i++)); do 
    echo $"Choose $i for this audio card:  ${audionamecard[$i]} "

done

 
read   
 
    if [[ -z "$REPLY" ]];then
        microphone="${audiocard[0]}"
    else
    echo $"MicroPhone selected "${audionamecard["$REPLY"]}"  "${audiocard["$REPLY"]}""
       microphone="${audiocard["$REPLY"]}"
    fi
    
REPLY=""
else
 microphone="${audiocard[0]}"
 fi 

 echo "seren -n $USER -d pulse -D plughw:$microphone"
	 seren -n $USER -d pulse -D plughw:$microphone


}
# alias parolepulse="parolefunction "
alias parole="/home/shared/git/parole-conference-010alpha17/./parole-conference -n $USER  -D plughw:2"

alias sourcehome="source ~/.bashrc"
alias openbashrc="kde-open ~/.bashrc"
alias alsamixer="alsamixer -V all"
# alias hdmirec=
screencastUSBMIC() {
i=0
file=/home/shared/Screencast/test-$i.mp4 
while [[  -e $file ]] 
do 
i=$((i+1)) 
file=/home/shared/Screencast/test-$i.mp4 
done

ffmpeg -thread_queue_size 512 -f alsa -ac 1 -ar 48000 -i hw:2,0  -s 1920x1080  -f x11grab -i :0  -r 30  -vcodec libx264 $file
 
}

screencastPCIMIC() {
i=0
file=/home/shared/Screencast/test-$i.mp4 
while [[  -e $file ]] 
do 
i=$((i+1)) 
file=/home/shared/Screencast/test-$i.mp4 
done

ffmpeg -thread_queue_size 512 -f alsa -ac 2 -ar 48000 -i hw:0,0  -s 1920x1080  -f x11grab -i :0  -r 30  -vcodec libx264 $file

echo $file
}

screencastMUTE() {
i=0
file=/home/shared/Screencast/test-$i.mp4 
while [[  -e $file ]] 
do 
i=$((i+1)) 
file=/home/shared/Screencast/test-$i.mp4 
done

ffmpeg -thread_queue_size 512 -s 1920x1080  -f x11grab -i :0  -r 30  -vcodec libx264 $file
 
 echo $file
}

playscreencast(){

ffplay $file
}

micrec(){
i=0
file=/home/shared/Screencast/audio-$i.flac 
while [[  -e $file ]] 
do 
i=$((i+1)) 
file=/home/shared/Screencast/audio-$i.flac
done

#license gpl 
#copyright nowardev@gmail.com


i=0
while read line ;do
audiocard[$i]="$line"
i=$(($i+1))
done< <( grep capture /proc/asound/pcm | cut -b 2)

i=0
while read line ;do
audionamecard[$i]="$line"
i=$(($i+1))
done< <(grep capture /proc/asound/pcm | cut -d : -f 2)

 
if [[ ${#audiocard[@]} >1 ]]; then 
echo $"I have detected more than 1 microphone in your computer please select what you want use (0-$((${#audiocard[@]}-1)))
"

 
 
i=0
for (( i=0 ; i <${#audiocard[@]};i++)); do 
    echo $"Choose $i for this audio card:  ${audionamecard[$i]} "

done

 
read   
 
    if [[ -z "$REPLY" ]];then
        microphone="${audiocard[0]}"
    else
    echo $"MicroPhone selected "${audionamecard["$REPLY"]}"  "${audiocard["$REPLY"]}""
       microphone="${audiocard["$REPLY"]}"
    fi
    
REPLY=""
else
 microphone="${audiocard[0]}"
 fi 

 echo " -f  alsa  -ac 1 -ar 48000 -i hw:$microphone,0  -vn $file"
	  -f  alsa  -ac 1 -ar 48000 -i hw:$microphone,0  -vn $file
 
}
pastebin(){
curl -F sprunge=@- sprunge.us


}

ksleep(){
dbus-send --print-reply --dest='org.freedesktop.PowerManagement' /org/freedesktop/PowerManagement org.freedesktop.PowerManagement.Suspend
}

kshutdown(){
qdbus org.kde.ksmserver /KSMServer logout 0 2 0

}

kreboot(){
qdbus org.kde.ksmserver /KSMServer logout 0 1 0
}
# # export SDL_VIDEO_X11_DGAMOUSE=0
# 

sleep24(){
echo $"Type time in this format  hh:mm  or hh:mm:ss"
read 
echo $REPLY
echo $(( $(date -d $REPLAY +%s)- $(date  +%s) ))
}

sleepdate(){
echo $"Type time in this format  02/27/2014  or 02/27/2014 10:19"
read 
echo $REPLY
echo $(( $(date -d $REPLAY +%s)- $(date  +%s) ))
}


upnp-add-tcp (){
upnpc -a $(hostname -I) $1 $1 TCP
}

upnp-add-udp (){
upnpc -a $(hostname -I) $1 $1 UDP
}

upnp-r-tcp (){
upnpc -d $1 TCP
}

upnp-r-udp (){
upnpc -d $1 UDP

}
upnp-list (){
upnpc -l

}

buildpackage(){
sudo dpkg-buildpackage -j $(grep -c ^processor /proc/cpuinfo) -b -rfakeroot -us -uc 
}


makejcore(){
make -j $(grep -c ^processor /proc/cpuinfo)
}

qemu-vmdk_img(){
	"$path_vmdk"="$1"  
	"$path_img"="${1%%.*}.img"
	
	qemu-img convert -f vmdk -O raw "$path_vmdk" "path_img"
 
}

qemu-vdi_img(){
	"$path_vdi"="$1"  
	"$path_img"="${1%%.*}.img"
	
	qemu-img convert -f vdi -O raw "$path_vdi" "path_img"
 
}

qemu-img_vmdk(){
	"$path_img"="$1"  
	"$path_vmdk"="${1%%.*}.vmdk"
	
	qemu-img convert -f raw -O vmdk  "path_img" "$path_vmdk"
 
}

qemu-img_vdi(){
	"$path_img"="$1"
	"$path_vdi"="${1%%.*}.vdi" 
	
	qemu-img convert -f raw -O vdi "path_img" "$path_vdi"
 
}

alias one="dh_make -s -c gpl"
alias two="debuild -uc -us --source-option=--include-binaries --source-option=-isession"
alias three="cd .. ; sudo pbuilder build"
alias four="debuild -k4E33C31A -S -sa"
alias five="dput ppa:nowardev/ppa  *source.changes"
 
extract () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1        ;;
             *.tar.gz)    tar xzf $1     ;;
             *.bz2)       bunzip2 $1       ;;
             *.rar)       rar x $1     ;;
             *.gz)        gunzip $1     ;;
             *.tar)       tar xf $1        ;;
             *.tbz2)      tar xjf $1      ;;
             *.tgz)       tar xzf $1       ;;
             *.zip)       unzip $1     ;;
             *.Z)         uncompress $1  ;;
             *.7z)        7z x $1    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}


xz-compress(){
tar cJvf ${1%%.*}.tar.xz "$1"
}

pastebin(){
curl -F sprunge=@- sprunge.us

}

cmakenowardev_usr(){
mkdir build ; cd build ; cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr .. 
}

git(){
cd /home/shared/git ; git clone git://source..org/.git -$(date +"%m-%d-%y");cd  -$(date +"%m-%d-%y") ; ./configure --help | awk -v ORS=" " '/enable/{print $1} END{printf "\n"}'
}
configure(){
 make clean ; ./configure --prefix=/usr/local   $(./configure --help|sort -r | awk  '/enable/{ print $1} END{printf "\n"}' | awk  '!/[A-Z]/ && !/avisynth/ && !/shared/ && !/poison/ && !/incompa/ && !/random/ && !/test/ && !/cross-compile/ && !/memalign-hack/ &&!/deck/ && !/libiec/ && !/libaacplus/ && !/libcelt/ && !/libflite/ && !/libilbc/ && !/libnut/ && !/opencv/ && !/shine/ && !/libstagefright/ && !/utvideo/ && !/vidstab/ && !/x265/ && !/libxavs/ && !/opencl/ && !/-rpath/ && !/ftrapv/ && !/hardcoded/ && !/major/ && !/libfdk-aac/ && !/opengl/ && !/enable-pic/ && !/enable-lto/ && !/small/ && !/gray/{print }'|awk -v ORS=" " '{print $1} END {printf "\n"}')
}


#mountvfat
mount_fat(){
sudo mount -t vfat 
}

#mountntfs
mount_ntfs(){
sudo mount -t ntfs-3g 
}




backup_partition(){
if [[ "$1" == -* ]]; then
	case "$1" in 
		-h) echo "backup_partition input_dev ouput_dev" ; return ;;
	esac
fi
echo  
if [[ ! -z $(ls /dev | grep "${1##*/}") &&  -d  "$2"  ]] ; then 
	if [[ ! -z $(grep "$1" /proc/mounts) ]]; then 
		echo $"$1 it's mounted please umount it before."
		return
	else
		date="$(date +"%d-%m-%y")"
		outname="$2/${1##*/}_$date.img"
		outname=${outname/\/\//\/} #remove potential // problem 
		echo $"do you want execute \"sudo dd if=\"$1\" of=\"$outname\" bs=4096 conv=notrunc,noerror\" (y\n) ?"
		read
		echo "$REPLY"
		case "$REPLY" in
			[yY]|[yY][eE][sS])
				sudo dd if="$1" of="$outname" bs=4096 conv=notrunc,noerror

			;;

			[nN]|[nN][oO])
				echo $"user exit"
				return
			;;
		esac

		
	fi
else 
	echo $"$1 it's a valid partition ? and $2 it's really folder ?"
 
fi
}

restore_partition(){
if [[ "$1" == -* ]]; then
	case "$1" in 
		-h) echo "restore_partition  output_device  INPUT_FILE" ; return ;;
	esac
fi

if [[ ! -z $(ls /dev | grep "${1##*/}") &&  -e  "$2"  ]] ; then 
	if [[ ! -z $(grep "$1" /proc/mounts) ]]; then 
		echo $"$1 it's mounted please umount it before."
		return 
	else
# 		date="$(date +"%d-%m-%y")"
# 		outname=${1##*/}_$date.img 
		echo $"doing sudo dd of="$1" if="$2" ?  (y\n) " 
		read   

		echo $REPLY
		case "$REPLY" in

		[yY]|[yY][eE][sS])
		
		sudo dd if="$2" of="$1"  

		;;

		[nN]|[nN][oO])
		echo $"user exit"
		return
		;;
		esac

	fi
else 
	echo $"$1 it's a valid partition ? and $2 it's really a file ?"
 
fi
}


backup_partition_two(){
# set -x
if [[ "$1" == -* ]]; then
	case "$1" in 
		-h) echo "backup_partition input_dev ouput_dev" ; return ;;
	esac
fi
echo  
if [[ ! -z $(ls /dev | grep "${1##*/}") &&  -d  "$2"  ]] ; then 
	if [[ ! -z $(grep "$1" /proc/mounts) ]]; then 
		echo $"$1 it's mounted please umount it before."
		return
	else
		date="$(date +"%d-%m-%y")"
		outname="$2/${1##*/}_$date.img"
		outname=${outname/\/\//\/} #remove potential // problem 
		echo $"do you want execute \"sudo dd if=\"$1\" of=\"$outname\" bs=4096 conv=notrunc,noerror\" (y\n) ?"
		read
		echo "$REPLY"
		case "$REPLY" in
			[yY]|[yY][eE][sS])
			
				sudo pv -p -t "$1" | dd  of="$outname" bs=4096 conv=notrunc,noerror

			;;

			[nN]|[nN][oO])
				echo $"user exit"
				return
			;;
		esac

		
	fi
else 
	echo $"$1 it's a valid partition ? and $2 it's really folder ?"
 
fi
}

restore_partition_two(){
if [[ "$1" == -* ]]; then
	case "$1" in 
		-h) echo "restore_partition  output_device  INPUT_FILE" ; return ;;
	esac
fi

if [[ ! -z $(ls /dev | grep "${1##*/}") &&  -e  "$2"  ]] ; then 
	if [[ ! -z $(grep "$1" /proc/mounts) ]]; then 
		echo $"$1 it's mounted please umount it before."
		return 
	else
# 		date="$(date +"%d-%m-%y")"
# 		outname=${1##*/}_$date.img 
		echo $"doing sudo dd of="$1" if="$2" ?  (y\n) " 
		read   

		echo $REPLY
		case "$REPLY" in

		[yY]|[yY][eE][sS])
		
		sudo pv -p -t "$2" | dd   of="$1"  

		;;

		[nN]|[nN][oO])
		echo $"user exit"
		return
		;;
		esac

	fi
else 
	echo $"$1 it's a valid partition ? and $2 it's really a file ?"
 
fi

}
rm-apt-repository(){
sudo add-apt-repository --remove "$1"
}

youtube2seren(){
ofile=$(date | md5sum | cut -b 1-32)                                                                                                   
youtube-dl -f 171 -o /tmp/$ofile "$1"

echo " -i /tmp/$ofile -ac 2 -ar 48000 -f s16le pipe:1 > ~/.seren/fifo_in"
 -i /tmp/$ofile -ac 2 -ar 48000 -f s16le pipe:1 > ~/.seren/fifo_in

}

chrootupgrade(){
a="/mnt/peace/chroot"						#set the folder to mount /
sudo mkdir -p "$a"						#create the folder 
sudo mount "$1" "$a"						#mounting the folder
sudo cp "$a/etc/resolv.conf" "$a/etc/resolv.conf.backup"
sudo cp  /etc/resolv.conf "$a/etc/resolv.conf"			#copy the resolv.conf file to get internet on chroot machine
sudo chroot "$a"
sudo apt-get update 						#update 
sudo apt-get upgrade 						#upgrade
sudo mv "$a/etc/resolv.conf.backup" "$a/etc/resolv.conf"	#restore the original resolv.conf
}

grepfolders(){
grep -r "$2" "$1"
}

sshrasp(){
ssh pi@192.168.0.3 
}

screencastVlc(){

i=0
while read line ;do
audiocard[$i]="$line"
i=$(($i+1))
done< <( grep capture /proc/asound/pcm | cut -b 2)

i=0
while read line ;do
audionamecard[$i]="$line"
i=$(($i+1))
done< <(grep capture /proc/asound/pcm | cut -d : -f 2)

 
if [[ ${#audiocard[@]} >1 ]]; then 
echo $"I have detected more than 1 microphone in your computer please select what you want use (0-$((${#audiocard[@]}-1)))
"

 
 
i=0
for (( i=0 ; i <${#audiocard[@]};i++)); do 
    echo $"Choose $i for this audio card:  ${audionamecard[$i]} "

done

 
read   
 
    if [[ -z "$REPLY" ]];then
        microphone="${audiocard[0]}"
    else
    echo $"MicroPhone selected "${audionamecard["$REPLY"]}"  "${audiocard["$REPLY"]}""
       microphone="${audiocard["$REPLY"]}"
    fi
    
REPLY=""
else
 microphone="${audiocard[0]}"
 fi 

 echo $microphone
# cvlc screen:// --screen-fps=12--input-slave=alsa://hw:0,0 --sout "#transcode{venc=x264,quality:100,scale=1,fps=30,acodec=mp4a,ab=128,channels=2, samplerate=44100}:duplicate{dst=std{access=file,mux=mp4,dst=desktop.mp4}}}"

}

kde_restart(){

export DISPLAY=:0
killall -9 plasmashell 
killall -9 krunner 
killall -9 kwin_x11
plasmashell & krunner & kwin_x11 --replace &


}

qemu_nowardev(){
ram=512 ; vnc="-vnc :1" ; hdd="-hda" ; soundcard=ac97 ;keyboard="it" ; qemu-system-x86_64 -machine pc,accel=kvm -m $ram -k $keyboard -soundhw $soundcard $vnc $hdd "$1"
}

qemu_iso(){
ram=512 ; vnc="-vnc :1" ; hdd="-hda /home/shared/virtualboxes/winxp.img" ; soundcard=ac97 ;keyboard="it" ; qemu-system-x86_64 $hdd -smp 2 -machine pc,accel=kvm -m $ram -k $keyboard -boot d -cdrom "$1"
# -soundhw $soundcard $vnc $hdd "$1"
}


locate_nowardev(){
sudo updatedb 
locate -i "$1"

}

youtubedlplaylist(){
musicfolder="$( xdg-user-dir MUSIC)"

if [[ ! -z "$musicfolder" ]] ; then  cd "$musicfolder" ;  fi
link="$1"
a="$(echo "${1/list=/ }" | cut -d " " -f 2)"
b="$(echo "${a/&/ }" | cut -d " " -f 1)"
echo " 

link:			$1
playlist:		$a
corrected playlist:	$b

running youtube-dl -t "$linkcorrected"
"

 
linkcorrected="www.youtube.com/playlist?list=$b"
youtube-dl -t "$linkcorrected"
}




function_scan_to_file(){
resolution="-r $3"
mode="-m $2"
destination="$1"

if [[ -z "$2" ]] ;then mode="-m grey" ; fi 
if [[ -z "$3" ]] ;then resolution="-r 100" ; fi

a=$(kdialog --progressbar "kde-service-menu-hp-scan: "$destination" " 100) #start kdialog 
echo "hp-scan   $resolution $mode -o "$destination" "
qdbus $a  showCancelButton true
qdbus $a org.kde.kdialog.ProgressDialog.autoClose true
b="false"
 
	while read line ; do 
		if [[ $line == 99 ]] ; then b="true" ; fi 
		
		while [[  $(qdbus  $a wasCancelled) != "false" && ! -z $(qdbus  $a wasCancelled)  ]] ; do
			echo -e "$COL_RED ECHO KILLING AXEL AND KDIALOG $COL_RESET"
			qdbus $a  org.kde.kdialog.ProgressDialog.close 
			exit
		done
# set -x		
		if [[ "$line" =~ ^[0-9]+$ ]]; then #check if is a number
		  
			if [[ "$line" != "$lineold" ]]; then 
				qdbus $a Set org.kde.kdialog.ProgressDialog value $line
				
			fi
		lineold=$line
		fi 
		
		
		if [[ $line == 0 && $b == "true" ]]; then 
			kdialog --passivepopup $"Job Done! file is here : $destination"
			qdbus $a Set org.kde.kdialog.ProgressDialog value 100
			qdbus $a  org.kde.kdialog.ProgressDialog.close 
# 			pkill -SIGTERM hp-scan
# 
# 			
		fi 
# 	set +x	
		
	done< <(hp-scan $resolution $mode -o "$destination"  | stdbuf -o0 tr '\r' '\n' |mawk -W interactive -F']' '{ print ($2+0) }'  )
			kdialog --title $"kde-service-menu-hp-scan"  --yesno  $" Do you want open the file?"
			if [[ $? == 0 ]] ; then
echo "kde-open "$1"" ; kde-open "$1"; fi 
 
}

function_scan_to_app() {
resolution="-r $3"
mode="-m $2"
app="-v $1"

if [[ -z "$2" ]] ;then mode="-m grey" ; fi 
if [[ -z "$3" ]] ;then resolution="-r 100" ; fi
echo "hp-scan   $resolution $mode  "$app""
a=$(kdialog --progressbar "kde-service-menu-hp-scan: "$destination" " 100) #start kdialog 

qdbus $a  showCancelButton true
qdbus $a org.kde.kdialog.ProgressDialog.autoClose true
b="false"
 
	while read line ; do 
		if [[ $line == 99 ]] ; then b="true" ; fi 
		
		while [[  $(qdbus  $a wasCancelled) != "false" && ! -z $(qdbus  $a wasCancelled)  ]] ; do
			echo -e "$COL_RED ECHO KILLING AXEL AND KDIALOG $COL_RESET"
			qdbus $a  org.kde.kdialog.ProgressDialog.close 
			exit
		done
# set -x		
		if [[ "$line" =~ ^[0-9]+$ ]]; then #check if is a number
		  
			if [[ "$line" != "$lineold" ]]; then 
				qdbus $a Set org.kde.kdialog.ProgressDialog value $line
				
			fi
		lineold=$line
		fi 
		
		
		if [[ $line == 0 && $b == "true" ]]; then 
			kdialog --passivepopup $"Job Done! file is here : $destination"
			qdbus $a Set org.kde.kdialog.ProgressDialog value 100
			qdbus $a  org.kde.kdialog.ProgressDialog.close 
# 			pkill -SIGTERM hp-scan
# 
# 			
		fi 
# 	set +x	
		
		
	done< <(hp-scan $resolution $mode "$app"  | stdbuf -o0 tr '\r' '\n' |mawk -W interactive -F']' '{ print ($2+0) }'  )
echo "hp-scan   $resolution $mode  "$app""
}


# copybashrc(){
# location="/home/shared/git/github/kde-peace-settings/bashrc/.bashrc"
# cp "$location" ~/.bashrc
# echo "copied "
# }


check_equal_array(){
a=($1)
b=($2)
}

pure_kde(){
a=($(apt-cache show kubuntu-desktop | awk '/Depen/ || /Rec/{ gsub(/\,/,"") ;gsub(/Recommends:/,"");gsub(/Depends:/,""); print} ' | awk '{ printf "%s ", $0 }'))
b=($(apt-cache show ubuntu-desktop | awk '/Depen/ || /Rec/{ gsub(/\,/,"") ;gsub(/Recommends:/,"");gsub(/Depends:/,""); print} ' | awk '{ printf "%s ", $0 }'))
c=($(apt-cache show xubuntu-desktop | awk '/Depen/ || /Rec/{ gsub(/\,/,"") ;gsub(/Recommends:/,"");gsub(/Depends:/,""); print} ' | awk '{ printf "%s ", $0 }'))
d=($(apt-cache show lubuntu-desktop | awk '/Depen/ || /Rec/{ gsub(/\,/,"") ;gsub(/Recommends:/,"");gsub(/Depends:/,""); print} ' | awk '{ printf "%s ", $0 }'))
e=($(apt-cache show mate-desktop | awk '/Depen/ || /Rec/{ gsub(/\,/,"") ;gsub(/Recommends:/,"");gsub(/Depends:/,""); print} ' | awk '{ printf "%s ", $0 }'))
toremove=()
tokeep=()


# a=( 1 2 3 )
# b=(a 2 c)
# echo ${a[@]}
# echo ${b[@]}
j=0

for r in "${a[@]}" ; do
	i=0
	for t in "${b[@]}" ; do
		if [[ "$r" == "$t" ]] ; then 
		echo "the array kubuntu-desktop contains $r which is even in the array *buntu-desktop so skipping it $t
unset ${b[$i]}"
# 			unset b[$i]
		tokeep+=("$r")
		

		else
		toremove+=("$r")
			
		fi
		i=$(($i+1))
	done
	
	j=$(($j+1))

	


done

echo "

package to remove to get pure kde 

${toremove[@]}




original metapackage :

${b[@]}


"
}

format_to_fat32(){
# sudo fdisk -l 
sudo mkdosfs -F 32 -I "$1"
}


format_to_btrfs(){
# sudo fdisk -l 
sudo mkfs.btrfs  -f "$1"
}

format_to_ext4_nojournal(){
sudo mke2fs -t ext4 -O ^has_journal "$1"
}

format_to_ext4(){
sudo mke2fs -t ext4 "$1"
}


format_to_ext3(){
sudo mke2fs -t ext3  "$1"
}
format_to_ntfs(){

sudo mkfs.ntfs -f "$1"

}

date-it(){
LC_ALL=it_IT.utf8 date

}

kwinrestarter(){
export $(dbus-session)
export DISPLAY=:0
kwin --replace 
}

kwinrestarter5(){
# export $(dbus-session)
export DISPLAY=:0  && kwin_x11 --replace

}

nocapslock(){
setxkbmap -option caps:none
}

yescapslock(){
setxkbmap -option
}


date-it(){
LC_ALL=it_IT.utf8 date

}

playdemout(){

 /home/shared/game/game4/UrbanTerror43/./Quake3-UrT.x86_64 +exec demowatcher.cfg   "$1"

}

east_c_old(){

 /home/shared/game/game4/UrbanTerror43/./Quake3-UrT.x86_64  +connect "216.52.148.134:27960" +exec keyboard.cfg 

}

bst_t(){
 /home/shared/game/game4/UrbanTerror43/./Quake3-UrT.x86_64  +connect "$(dig +short urt.bsturt.info):27960" +exec keyboard.cfg 

}


bst_j_old(){
 /home/shared/game/game4/UrbanTerror43/./Quake3-UrT.x86_64  +connect "$(dig +short urt.bsturt.info):27961"  +exec keyboard.cfg 

}

bst_j(){
/home/shared/game/game4/UrbanTerror43/./Quake3-UrT.x86_64   +connect "$(dig +short urt.bsturt.info):27965"  +exec keyboard.cfg 

}



bst_c(){
 /home/shared/game/game4/UrbanTerror43/./Quake3-UrT.x86_64  +connect "$(dig +short urt.bsturt.info):27962"  +exec keyboard.cfg 

}

bst_m(){
/home/shared/game/game4/UrbanTerror43/./Quake3-UrT.x86_64   +connect "$(dig +short urt.bsturt.info):27963"  +exec keyboard.cfg  +password fun

}

urbanterror(){
if [[ -z $1 ]]; then 

 /home/shared/game/game4/UrbanTerror43/./Quake3-UrT.x86_64  "$1" "$2" +exec keyboard.cfg
else
 /home/shared/game/game4/UrbanTerror43/./Quake3-UrT.x86_64  +connect "$1" +exec keyboard.cfg 
fi 
}
urbanterrorserver(){
 /home/shared/game/game4/UrbanTerror43/./Quake3-UrT.x86_64   +exec normalserver.cfg  +exec keyboard.cfg
}

urbanterror_ctf_my_server(){
 /home/shared/game/game4/UrbanTerror43/./Quake3-UrT.x86_64   +exec serverctf.cfg  +exec keyboard.cfg
}
playdemout(){

 /home/shared/game/game4/UrbanTerror43/./Quake3-UrT.x86_64 +exec demowatcher.cfg   "$1"

}

east_c_old(){

 /home/shared/game/game4/UrbanTerror43/./Quake3-UrT.x86_64  +connect "216.52.148.134:27960" +exec keyboard.cfg +exec keyboard.cfg 

}

east_c(){

for file in /home/sem/.q3a/q3ut4/east/* ; do  cp $file /home/sem/.q3a/q3ut4/ ; done  ; rm /home/sem/.q3a/q3ut4/authkey
/home/shared/game/game4/UrbanTerror43/./Quake3-UrT.x86_64   +connect "216.52.148.134:27960" +exec keyboard.cfg 
for file in /home/sem/.q3a/q3ut4/copy4.3settings/* ; do  cp $file /home/sem/.q3a/q3ut4/ ; done 
}


bst_t3(){
/home/shared/game/game4/UrbanTerror43/./Quake3-UrT.x86_64  +connect "$(dig +short urt2.bsturt.info):27960" +exec keyboard.cfg +password vilain

}







urbanterrormyserverCONNECT(){
 /home/shared/game/game4/UrbanTerror43/./Quake3-UrT.x86_64  +exec keyboard.cfg +connect $(dig +short myip.opendns.com @resolver1.opendns.com):27960
}

keyboard_disabler(){
keyboard=$(xinput --list | grep 'AT Translated' | cut -f 2 |cut -d = -f  2)
xinput set-int-prop "$keyboard"  "Device Enabled" 8 0

}

keyboard_enabler(){
keyboard=$(xinput --list | grep 'AT Translated' | cut -f 2 |cut -d = -f  2)
xinput set-int-prop "$keyboard"  "Device Enabled" 8 1

}

openbashrcgit(){
kde-open /home/shared/git/github/kde-peace-settings/bashrc/.bashrc
}

copybashrc_to_home(){
cp /home/shared/git/github/kde-peace-settings/bashrc/.bashrc ~/.bashrc
source ~/.bashrc
echo "copied and sourced"
}

dolphingit(){
dolphin /home/shared/git/github/kde-peace-settings/bashrc/
}

myip(){
dig +short myip.opendns.com @resolver1.opendns.com
}

check_router_door(){ 
# echo $"Port to scan Example of proper form: \"-100,200-1024,T:3000-4000,U:60000-\""
# read   
# 
#     if [[ -z "$REPLY" ]];then
#         port="tcp"
#     else
#         port="$REPLY"
#     fi
# REPLY=""
# echo
# 
# variable="$port" 
# 
# case "$variable" in
# 
# 1)tcp
# 
# ;;
# 2)
# ;;
# *)
# echo $"invalid option sorry... exiting"
# exit 2
# ;;
# esac

ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
#nmap -p U:27960,T:27960 $ip 
sudo nmap -T5 -A -p  27950,27960 -sU $ip 
}

check_listening_port(){
ss -tul
}

swapoffon(){
sudo swapoff -a && sudo swapon -a 
}
sem_swapoff(){
sudo swapoff -a 
}

lsdate(){

ls -t "$PWD"
}


lsdatereverse(){

ls -tr "$PWD"
}

dlyoutube(){
youtube-dl -t "$1"
}

qrencodeauto(){
qrencode -o /tmp/rencode.jpeg "$1"
echo "qrencode -o /tmp/rencode.jpeg "$1"" 

}
wgetwebsite(){


#pass="$(read -p "password")"
#username="$(read -p "username")"
cd /tmp ; wget --http-user=$username --http-password=$pass https://www.ubibanca.com/
}

swapcheker(){
free -m | awk '/buffers\/cache/{print $4}'
}

linksem(){

read -e -p "
REMEMBER YOU HAVE TO BE IN THE FOLDER WHERE YOU WANT TO LINK A FOLDER THAT WILL HAVE THE SAME NAME

insert folder to link: 

"

#get last char to check if / or somehting else
i="$((${#REPLY}-1))"
lastchar="${REPLY:$i:1}"

if [[ "$lastchar" == "/" ]] ; then 
name=${REPLY%*/} ; name=${name##*/}
else
name="${REPLY%/*} "
fi
#pwd the actual folder

 
echo doing "ln -s "$REPLY" "$PWD/$name""
ln -s "$REPLY" "$PWD/$name"
echo 'done!'

}
plasmashellinteractiveconsole(){
 qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.showInteractiveConsole

}

screenshotunder(){
i=0
file="/tmp/Screenshot-$i.jpeg"
while [[  -e $file ]] 
do 
i=$((i+1)) 
file="/tmp/Screenshot-$i.jpeg"
done
sleep 3;     spectacle -a -f -b -d 3 -o "$file"
}

screenshotunder_text(){
outfolder="/tmp"
tempfilename="$outfolder/hello.jpeg"
i=0
file="/tmp/Screenshot-$i.jpeg"
while [[  -e $file ]] 
do 
i=$((i+1)) 
file="/tmp/Screenshot-$i.jpeg"
done
kdialog --yesno "Click Yes to grab the screenshot"
sleep 3;     spectacle -f -b -u  -o "$file" 

convert "$file" -gravity south -stroke '#000C' -strokewidth 2 -pointsize 48 -annotate 0   'Nowardev.wordpress.com' -stroke  none   -fill white  -pointsize 48  -annotate 0 'Nowardev.wordpress.com'  "$tempfilename" 
cp "$tempfilename" "$file"
echo "convert "$tempfilename" -gravity south -stroke '#000C' -strokewidth 2 -annotate 0 -pointsize 48  'Nowardev.wordpress.com' -stroke  none   -fill white    -annotate 0 -pointsize 48 'Nowardev.wordpress.com'  "$file" "
          
}

mkdirmultiple(){
mkdir -p "$1"
}

qemuiso(){
ram="1024"
vnc="-vnc :1" #enable vnc
hdd="-hda"
soundcard="ac97"
keyboard="it"
echo "qemu-system-x86_64  -machine pc,accel=kvm -m $ram -k $keyboard -soundhw $soundcard $vnc $hdd "/home/shared/virtualboxes/mynew_qemu_image.img" -boot d -cdrom /home/shared/iso 2016/neon-devedition-gitstable-20170102-1047-amd64.iso"

qemu-system-x86_64  -machine pc,accel=kvm -m $ram -k $keyboard -soundhw $soundcard $vnc $hdd "/home/shared/virtualboxes/mynew_qemu_image.img" -boot d -cdrom "/home/shared/iso 2016/neon-devedition-gitstable-20170102-1047-amd64.iso"

}

scan-multiple-pages-to-pdf(){
# hp-scan --adf -o "$1.pdf"

tempimagefolder="$1"

if [[  -d "$tempimagefolder"  ]] ; then
rm -R "$tempimagefolder" 
mkdir "$tempimagefolder"
else
mkdir "$tempimagefolder"
fi 


resolution=100
a="$PWD"
cd "$tempimagefolder" 
scanimage -b --batch-count=n --source ADF --resolution $resolution 
b=()
for file in *.pnm ; do  b=("${b[@]}" "$file") ; done 
convert "${b[@]}" "$a/$1.pdf"
cd "$a" 
}

scan-multiple-images(){
tempimagefolder="$1"
directory="$tempimagefolder"
if [[  -d "$directory"  ]] ; then
rm -R "$directory" 
mkdir "$tempimagefolder"
else
mkdir "$tempimagefolder"
fi 


resolution=100
a="$PWD"
cd "$tempimagefolder" 
scanimage -b --batch-count=n --source ADF --resolution $resolution 
for file in *.pnm ; do convert "$file" "${file%%.*}.jpg" ; done 


}

gitdownload_folder(){
a="$1"
svn checkout ${a/tree\/master/trunk}

}

sudokate (){

if [[ ! -z "$1" ]] ; then 
set -x
folder="${1%/*}"
filename="${1##*/}"
cp "$1" /tmp/"$filename"
set +x 
kate  /tmp/"$filename"
set -x 
kdialog --password $"please insert Root Password to save the file" | sudo -S mv "/tmp/$filename" "$1"
    if [[ $? != 0 ]] ; then 
        kdialog  --passivepopup  $" YOUR FILE IS NOT SAVED! WRONG PASSWORD! your modifications are saved in /tmp folder" 3
    else
        rm "/tmp/$filename"
    
    fi 
    set +x
else 
    kdialog --title $"SudoKate"  --passivepopup  $" No file selected..exiting" 3
    exit 
fi

}

rotatepdfright90(){

 pdftk "$1" cat 1east output "${1%%.*}_r".pdf 
}
