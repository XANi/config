export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM="verbose name"
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWUPSTREAM="verbose"
export GIT_PS1_DESCRIBE_STYLE=branch
source  /usr/lib/git-core/git-sh-prompt
setopt PROMPT_SUBST
autoload -U regexp-replace
no_processors=$(cat /proc/cpuinfo | grep ^processor|wc -l)
home_host_regex='^(ghroth|erise|arkham|vm-debian|hydra)'

# fallback default
get_load_color() {
    read load </proc/loadavg
    load_regex='([0-9]+).*'
    if [[ $load =~ $load_regex ]] ;then
        SYSTEM_LOAD=$match
        if [ $SYSTEM_LOAD -lt 1 ] ; then
            LOADCOLOR="%{$fg_bold[black]%}"
        elif [ $SYSTEM_LOAD -lt $no_processors ] ; then
            LOADCOLOR="%{$fg_bold[green]%}"
        elif [ $SYSTEM_LOAD -lt $((no_processors * 2)) ] ; then
            LOADCOLOR="%{$fg_bold[yellow]%}"
        else
            LOADCOLOR="%{$fg_bold[red]%}"
        fi
    fi
    echo -ne  $LOADCOLOR
}


PROMPT_LOAD_COLOR='$(get_load_color)'
pipe_status(){
    st=$pipestatus
    RE_MATCH_PCRE=1
    if [[ $pipestatus =~ '^0( 0)*$' ]] ; then
    # echo -n "%{$fg_bold[green]%}OK%{$reset_color%}"
    else
        regexp-replace st '\s' '|'
        echo -n "%{$fg_bold[red]%}$st%{$reset_color%}"
    fi

}

whoami() {
    if [[ $HOSTNAME =~ $home_host_regexp ]]; then
        echo -n "%{$fg_bold[green]%}^%{$reset_color%}"
    else
        echo -ne "%{$fg_bold[green]%}$HOSTNAME%{$reset_color}"
    fi
}

user_prompt() {
    if [ $USER = 'xani' ] ; then
        echo -n 'ᛯ'
    elif [ $USER = 'root' ] ; then
        echo -n "%{$fg_bold[red]%}☠"
    else
        echo -n "%{$fg_bold[cyan]%}$USER %{$reset_color%}ᛯ"
    fi
}

user_color() {
    if [ $USER = 'xani' ] ; then
        echo -n "%{$fg_bold[blue]%}"
    elif [ $USER = 'root' ] ; then
        echo -n "%{$fg_bold[red]%}"
    else
        echo -n "%{$fg_bold[green]%}"
    fi
}

P1=$'%{$fg_bold[black]%}%D{[%H:%M:%S]}%{$reset_color%} $(whoami) $(user_color)[%~]%{$reset_color%}%{$fg_bold[white]%} '
P2='%{$reset_color%}
$(get_load_color)->%{$fg_bold[blue]%} $(user_prompt)%{$reset_color%} '
precmd () { __git_ps1 $P1 $P2 '{%s}' }

PS2="%{$fg_bold[blue]%}%_> %{$reset_color%}"

RPROMPT='$(pipe_status)'

#PROMPT=$'%{$fg_bold[green]%}%n@%m %{$fg[blue]%}%D{[%I:%M:%S]} %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%} $(__git_ps1)\
#%{$fg[blue]%}->%{$fg_bold[blue]%} %#%{$reset_color%} '

# not used, only for builtin git support
#ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
#ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
#ZSH_THEME_GIT_PROMPT_CLEAN=""
