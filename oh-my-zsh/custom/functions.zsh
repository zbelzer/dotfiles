# Welcome message for login shells
if [[ $SHLVL -eq 1 ]] ; then
   echo
   print -P "\e[1;32m Welcome to: \e[1;34m%m"
   print -P "\e[1;32m Running: \e[1;34m`uname -srm`\e[1;32m on \e[1;34m%l"
   print -P "\e[1;32m It is:\e[1;34m %D{%r} \e[1;32m on \e[1;34m%D{%A %b %f %G}"
   echo
fi

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Custom commands
extract() {
   if [[ -z "$1" ]] ; then
      print -P "usage: \e[1;36mextract\e[1;0m < filename >"
      print -P "       Extract the file specified based on the extension"
   elif [[ -f $1 ]] ; then
      case ${(L)1} in
         *.tar.bz2)  tar -jxvf $1 ;;
         *.tar.gz)   tar -zxvf $1 ;;
         *.bz2)      bunzip2 $1    ;;
         *.gz)       gunzip $1     ;;
         *.jar)      unzip $1       ;;
         *.rar)      unrar x $1    ;;
         *.tar)      tar -xvf $1     ;;
         *.tbz2)     tar -jxvf $1 ;;
         *.tgz)      tar -zxvf $1 ;;
         *.zip)      unzip $1       ;;
         *.Z)        uncompress $1  ;;
         *)          echo "Unable to extract '$1' :: Unknown extension"
      esac
   else
      echo "File ('$1') does not exist!"
   fi
}

calendar() {
   if [[ ! -f /usr/bin/cal ]] ; then
      echo "Please install cal before trying to use it!"
      return
   fi

   if [[ "$#" = "0" ]] ; then
      /usr/bin/cal | egrep -C 40 --color "\<$(date +%e| tr -d ' ')\>"
   else
      /usr/bin/cal $@ | egrep -C 40 --color "\<($(date +%B)|$(date +%e | tr -d ' '))\>"
   fi
}

alias cal=calendar

basiccalc() {
   if [[ ! -f /usr/bin/bc ]] ; then
      echo "Please install bc before trying to use it!"
      return
   fi

   if [[ -z "$1" ]] ; then
      /usr/bin/bc -q
   else
      echo "$@" | /usr/bin/bc -l
   fi
}

alias bc=basiccalc

echon() {
   # Convert to normal 0th element access
   local loc=$1
   shift

   echo $@[(w)$loc]
}

mkcd() {
   if [[ -z "$1" ]] ; then
      echo "usage: \e[1;36mmkcd \e[1;0m< directory >"
      echo "       Creates the specified directory and then changes it to pwd"
   else
      if [[ ! -d $1 ]] ; then
         mkdir -p $1 && cd $1
      else
         cd $1
      fi
   fi
}

unkey_host() {
   if [[ -z "$1" ]] ; then
      echo "usage: \e[1;36munkey_host \e[1;0m< host >"
      echo "       Removes the specified host from ssh known host list"
   else
      sed -i -e "/$1/d" $HOME/.ssh/known_hosts
   fi
}

op() {
    echo "Opening ${1} in NERDTree GVim"
    cd "${HOME}/${1}"
    gvim -c NERDTree 2>/dev/null
}
