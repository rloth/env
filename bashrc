# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=10000

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


# --> mon beau prompt
PS1='\[\e[1;32m\]\w >\[\e[m\] '


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

# --> mon grep jaune
export GREP_COLOR='1;33'
# some more ls aliases
alias ll='ls -lhGF --time-style long-iso'
alias la='ls -A'
alias l='ls -CF'

# MES ALIAS UTILES
# -----------------

alias dockpsid="docker ps -a --format 'table {{.Names}}\t{{.ID}}\t{{.Image}}\t{{.Status}}'"
alias dockps="docker ps -a --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}'"

alias charinfo="od -ctx1"

alias L2U='iconv -f iso-8859-1 -t utf-8'

alias U2L='iconv -f utf-8 -t iso-8859-1'
# translittération et décompression pdf
alias pdftruc='pdftk - output - uncompress | tr "[\000-\011\013-\037\177-\377]" "²"'

alias fix_europress='perl -pe "s!<((?:input|img|meta)) ([^>]+[^>/])>!<\1 \2></\1>!g ; s/&nbsp;/&#160;/g"'

alias comex-params="nano /home/romain/comex2/config/parametres_comex.ini"

function linesizes() {
  i=0;
  cat $1 | while read line ;
    do
      i=$(($i+1)) ;
      nchars=`echo $line | wc -c` ;
      echo -e "$i\t$nchars"  ;
    done
}



# for instance:
# > apt_rm_re 4.4.0-43
function apt_rm_re() { sudo apt-get remove $(dpkg -l | grep ^ii | grep $1 | tr -s ' ' '\t' | cut -f2 | perl -pe 's/\n/ /' ); }

alias go='nautilus . &'

# ls git
alias lsgit="git ls-tree -l --abbrev=7 HEAD | tr -s ' ' ' ' | cut -f 2,3,4,5 -d ' ' --output-delimiter='       ' | sort -k 3dr,4.2"
    # Exemple
    # blob	eacfda3	4127	README.md
    # blob	5a89ed4	938	exemple_refbibs.tei.xml
    # tree	1c19350	-	bib-findout-api
    # tree	3ada14b	-	bib-install-vp
    # tree	4390e1f	-	bib-get
    # tree	dd30954	-	doc
# a diff (vs 'unstable' branch) for a patch
alias gitpatchunstable="git format-patch unstable --stdout"

# todo (add git msg in content beiing grepped cf. so)
function grepgit() {
    git grep -P $1 $(git rev-list --all) ;
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias ps='ps --forest'

alias esearchd='curl -XPOST viistex.intra.inist.fr:9200/_search -d'
# eg  esearchd '{size:1,query:{query_string:{query:"inverted siphon"}}}' | jq '.'
# cf. http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl.html
# et  http://okfnlabs.org/blog/2013/07/01/elasticsearch-query-tutorial.html

alias cgoban='java -jar /home/romain/zmine/gamez/cgoban.jar'


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

PATH="~/bin:~/tw/my_iscpif_tools:~/istex/bin:~/istex/refbibs-stack/bib-adapt-corpus:~/perl5/bin:${PATH}";
export PATH;

PERL5LIB="~/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="~/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"~/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=~/perl5"; export PERL_MM_OPT;

export JAVA_HOME="/usr/lib/jvm/jdk1.8.0_65/"

# echo "NEWS: ssh rloth@tina.iscpif.fr"

export GROBID_HOME="~/istex/grobid/grobid-home"


#~ export HTTP_PROXY="http://proxyout.inist.fr:8080"
#~ export http_proxy="http://proxyout.inist.fr:8080"
#~ export HTTPS_PROXY="https://proxyout.inist.fr:8080"
#~ export https_proxy="https://proxyout.inist.fr:8080"
#~ export FTP_PROXY=http://proxyout.inist.fr:8080/
#~ export ftp_proxy=http://proxyout.inist.fr:8080/
#~ no_proxy="localhost, 127.0.0.1, .inist.fr"

# todo InCJK_Unified_Ideographs \u4E00-\u9FFF



# for my gargantext install ----------------------------------

# export GT_SRV='/srv/classic_install'           # classic (manual) install
export GT_SRV='/srv'                           # normal (docker) install

export GT_HOME="/home/romain/gt/unstablegit"

# to start gt venv
alias gt_venv='source $GT_SRV/env_3-5/bin/activate'

# to start nlpserver
alias gt_nlpserver='gnome-terminal -x bash -c "source $GT_SRV/gargantext_env/bin/activate ; bash /srv/gargantext/gargantext/util/taggers/lib/nlpserver/launchServeur.sh"'

alias cdgt="cd /srv/gargantext"
# avec auparavant cd srv/gargantext_lib/taggers/nlpserver
#                 ln -s turboparser.cpython-34m.so turboparser.so

# for generic jobs --------------------------------------------

alias mountsdc1="sudo mount /dev/sdc1 /media/romain/truc/"

alias comexdb-ip="docker inspect comex_db | jq -r '.[0].NetworkSettings | [.Networks[].IPAddress,(.Ports|keys[])]'"

alias dev.communityexplorer.org="~/dev.communityexplorer.org"


comex-stop-backends()
{
    cd /home/romain/comex2/setup/dockers
    docker-compose down
}

docker-ip()
{
    docker inspect $1 | jq -r '.[0].NetworkSettings | [.Networks[].IPAddress,(.Ports|keys[])] | @tsv'
}

alias dockip=docker-ip

alias comex-ps="ps -f | grep ^rom | grep -A12 dev\."

alias tina_nodes_clean="jq '.nodes | map(del(.content))'"


# Play go :)
alias cgoban="java -jar /home/romain/zmine/gamez/cgoban.jar"


# remove newlines
alias chomp="perl -pe 's/\n/ /'"
