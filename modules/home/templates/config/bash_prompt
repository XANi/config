#!/bin/bash
<%- if ! @portable_config -%>
# <%= @puppet_header %>
# <%=  __FILE__.gsub(/.*?puppet\//,@fqdn + ':') %>
<%- end -%>
# restore original term if its set to xterm-256, and save orig. term otherwise
# needed for sudo passing $TERM in env
# fixing centos 6 default crap
unalias -a
export SHELL=/bin/bash # mc fix
                       #
if [ $TERM = 'dumb' ] ; then
    # not a real term, dont bother with setting up env
    # cant just exit here because for some reason it fucks up scp to centos6
    echo -n ''
else

if [ $TERM = 'xterm-256color' ] ; then
    export TERM=$ORIGTERM
else
    export ORIGTERM=$TERM
fi

home_host_regex='^(ghroth|erise|arkham|vm-debian|hydra)'
if [[ $HOSTNAME =~ $home_host_regex ]] ; then
    SHOW_HOSTNAME=0
    if [ "$USER" = "root" ] ; then
        PROMPT_NO_HOST='\[\033[1;31m\] (!) \[\033[1;30m\]$NICKNAME\[\033[0m\]'
#    elif [ "$USER" = "root" ] ; then
#        PROMPT_NO_HOST='\[\033[40;1;32m\] =!!> \[\033[1;30m\]$NICKNAME\[\033[0m\]'
#    else
#        PROMPT_NO_HOST='\[\033[40;1;32m\] ==> \[\033[1;30m\]$NICKNAME\[\033[0m\]'
    fi
else
    SHOW_HOSTNAME=1
fi


bad_terms='(linux|eterm-color)'
if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0000000" #black
    echo -en "\e]P8333333" #darkgrey
#    echo -en "\e]P1803232" #darkred
#    echo -en "\e]P9982b2b" #red
#    echo -en "\e]P25b762f" #darkgreen
#    echo -en "\e]PA89b83f" #green
#    echo -en "\e]P3aa9943" #brown
#    echo -en "\e]PBefef60" #yellow
#    echo -en "\e]P4324c80" #darkblue
#    echo -en "\e]PC2b4f98" #blue
#    echo -en "\e]P5706c9a" #darkmagenta
#    echo -en "\e]PD826ab1" #magenta
#    echo -en "\e]P692b19e" #darkcyan
#    echo -en "\e]PEa1cdcd" #cyan
#    echo -en "\e]P7ffffff" #lightgrey
#    echo -en "\e]PFdedede" #white
fi

if [[ $TERM =~ $bad_terms ]] ; then
    TERMTITLE=""
else
    export TERM=xterm-256color
    if [ $SHOW_HOSTNAME -eq 1 ] ; then
        TERMTITLE='\[\033]0;\h[\u]:\w\007\]'
    else
        TERMTITLE='\[\033]0;[\u]:\w\007\]'
    fi
fi

TIME='[\D{%T}]'

PROMPT_DIR='\[\033[1;34m\]\w\[\033[0m\]'

if [ -e /usr/lib/git-core/git-sh-prompt ] ; then
    source /usr/lib/git-core/git-sh-prompt
elif [ -e /etc/bash_completion.d/git ] ;then
    source /etc/bash_completion.d/git
elif [ -e /usr/share/git-core/contrib/completion/git-prompt.sh ] ; then
    source /usr/share/git-core/contrib/completion/git-prompt.sh
fi


if type __git_ps1 2>/dev/null |grep -q -P '(funct|funk)' ; then
    PROMPT_GIT='\[\033[1;35m\]$(__git_ps1)\[\033[0m\]'
fi
if [ "$USER" = "root" ] ; then
    PROMPT_HOSTNAME='\[\033[1;31m\]\h\[\033[1;30m\]$NICKNAME\[\033[0m\]'
    PROMPT_END='\[\033[0;31m\]☠\[\033[0m\] '
elif [ "$USER" = "xani" ] ; then
    PROMPT_HOSTNAME='\[\033[40;1;32m\]\h\[\033[1;30m\]$NICKNAME\[\033[0m\]'
    PROMPT_END='\[\033[0m\]ᛯ\[\033[0m\] '
else
    PROMPT_HOSTNAME='\[\033[40;1;32m\]\h\[\033[1;30m\]$NICKNAME\[\033[0m\]'
    PROMPT_USER='\[\033[1;36m\]\u\[\033[0m\]@'
    PROMPT_END='\[\033[0m\]ᛯ\[\033[0m\] '
fi

if [ $SHOW_HOSTNAME -eq 0 ] ; then
    PROMPT_HOSTNAME=''
fi
read load </proc/loadavg
# yes ofc bash does not have PCRE things like \d -_-
load_regex='([0-9]+).*'
if [[ $load =~ $load_regex ]] ;then
    SYSTEM_LOAD=${BASH_REMATCH[1]}
fi
no_processors=$(cat /proc/cpuinfo | grep ^processor|wc -l)

if [ $SYSTEM_LOAD -gt $((no_processors * 4)) ] ; then
    SYSTEM_OVERLOAD=1
fi

# fallback default
LOADCOLOR='\[\033[1;30m\]'
get_load_color() {
    read load </proc/loadavg
    if [[ $load =~ $load_regex ]] ;then
        SYSTEM_LOAD=${BASH_REMATCH[1]}
        if [ $SYSTEM_LOAD -lt 1 ] ; then
            LOADCOLOR='\033[1;30m'
        elif [ $SYSTEM_LOAD -lt $no_processors ] ; then
            LOADCOLOR='\033[40;1;32m'
        elif [ $SYSTEM_LOAD -lt $((no_processors * 2)) ] ; then
            LOADCOLOR='\033[1;33m'
        else
            LOADCOLOR='\033[1;31m'
        fi
    fi
    echo -e  $LOADCOLOR
}
PROMPT_LOAD_COLOR='$(get_load_color)'


# get exit status of each command if it's not zero
#
#
export PROMPT_COMMAND="
       _RES=\${PIPESTATUS[*]};
       _RES_STR='';
       _OK=1;
       for res in \$_RES; do
         if [[ ( \$res > 0 ) ]]; then
           _RES_STR=\${_RES// /|};
         fi;
       done;
"
export PROMPT_EXIT_COLOR='\033[1;33m'

export PS1="${TERMTITLE}${PROMPT_NO_HOST}\[${PROMPT_LOAD_COLOR}\]${TIME}${PROMPT_USER}${PROMPT_HOSTNAME}:$PROMPT_DIR${PROMPT_GIT}\[$PROMPT_EXIT_COLOR\]\$_RES_STR${PROMPT_END}"

export PATH="/usr/kerberos/sbin:/usr/kerberos/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"

if [ -e /etc/redhat-release ] ; then # yum is yuck
    alias apt-get="yum"
    alias aptitude="yum"
    alias apt-cache="yum"
fi
alias d="if [ -e .svn ] ; then svn diff | colordiff |less -R ; else git diff --word-diff --no-prefix; fi"
alias g='git'
alias s='svn'
alias svn-addprop="svn propset svn:keywords \"Revision LastChangedBy Date URL\""
alias man="LC_ALL=C man"
alias kj="killall -9 java"
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias varnishadm="rlwrap -pgreen -S'varnish> ' varnishadm"
alias va='vagrant'
alias sqlite="sqlite3"
alias riak-admin="sudo -u riak riak-admin"
alias tdump='tcpdump -i any -s 0 -n -U -C 108 -W 5 -w dump_$(hostname)_$(date +%F_%T).'

chmod go-rwx ~/.saved >/dev/null 2>&1

disc() {
    if [ "z$1" = "zall" ] ; then
        lshw -short
        free -m -t
    fi
    ip addr show| grep 'inet '
}


# git PS1 features:
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWSTASHSTATE=1
# "verbose" for count of changes, auto for only < >
export GIT_PS1_SHOWUPSTREAM="verbose"

<% if has_variable?('portable_config') then -%>
# fix another c6 fucktardness
if [ "$SUDO_USER" = "xani" ] ; then
    if [ "$SUDO_COMMAND" != "/bin/su" ]; then
        export HOME=~xani
    fi
fi
export EDITOR=emacs
<% else -%>
export GOPATH=/home/xani/lib/go
export PATH=$PATH:/home/xani/lib/go:/usr/games
export EDITOR='/usr/local/bin/e'
alias emacs='echo use e $@'
alias ytd='youtube-dl -t --console-title'
alias aptitude='sudo aptitude'
alias cfg='cd ~/src/my/config'
alias pup='cd ~/src/svn-puppet 2>/dev/null || cd ~/src/puppet 2>/dev/null || cd ~/src/my/cluster'
export SSH_ASKPASS="/usr/local/bin/ssh-askpass-wrapper"

# shortcut for quick sshfs
sshmount() {
    SSHFS_SERVER_DIR='/home/xani'
    if [ "z$1" == "z" ] ; then
        echo "specify server [server_dir]"
        return
    fi
    SSHFS_SERVER=$1
    if [ "z$2" != "z" ] ; then
        SSHFS_SERVER_DIR=$2
    fi
    SSHFS_TARGET_DIR="/home/xani/mnt/$SSHFS_SERVER"
    echo "Mounting $SSHFS_SERVER:$SSHFS_SERVER_DIR into $SSHFS_TARGET_DIR"
    mkdir -p $SSHFS_TARGET_DIR
    sshfs -o idmap=user -o allow_other -o kernel_cache $SSHFS_SERVER:$SSHFS_SERVER_DIR $SSHFS_TARGET_DIR && cd $SSHFS_TARGET_DIR
}

<%- if scope.lookupvar('home::common::http_proxy') -%>
export http_proxy="<%= scope.lookupvar('home::common::http_proxy') %>"
<%- end -%>

<%- if scope.lookupvar('home::common::https_proxy') -%>
export https_proxy="<%= scope.lookupvar('home::common::https_proxy') %>"
<%- end -%>

<%- if scope.lookupvar('home::common::perl5lib') -%>
export PERL5LIB="<%= scope.lookupvar('home::common::perl5lib').join(':') %>"
<%- end -%>

# load gpg agent info if shell (like anything in xsession) gets loaded before gpg-agent started

if [ ! -r $GPG_AGENT_INFO ] ; then
    #   echo "no gpg agent in session!"
    export GPG_AGENT_FILE="/home/xani/.gnupg/gpg-agent-info-$HOSTNAME"
    if [ -e $GPG_AGENT_FILE ] ; then
        #        echo "adding one from $GPG_AGENT_FILE"
        source $GPG_AGENT_FILE
        export GPG_AGENT_INFO
    fi
fi


<% end -%>
if [ ! -e /usr/local/bin/e ] && [ ! -e /usr/bin/e ]  ; then
    alias e='emacs'
fi
<% if has_variable?('portable_config') then -%>
<% if File.exists?(scope.lookupvar('home::common::homedir') + '/.bash_prompt_custom') %>
<%= scope.function_template([scope.lookupvar('home::common::homedir') + '/.bash_prompt_custom']) %>
<% end %>
<% end %>
export GIT_AUTHOR_NAME="<%= @git['author']['name'] %>"
export GIT_AUTHOR_EMAIL="<%= @git['author']['email'] %>"
export GIT_COMMITTER_NAME="<%= @git['committer']['name'] %>"
export GIT_COMMITTER_EMAIL="<%= @git['committer']['email'] %>"
fi
