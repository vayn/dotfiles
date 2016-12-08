colord() {
    PROMPT_PATH=""

    CURRENT=`dirname ${PWD}`
    if [[ $CURRENT = / ]]; then
        PROMPT_PATH=""
    elif [[ $PWD = $HOME ]]; then
        PROMPT_PATH=""
    else
        PROMPT_PATH=$(print -P %3~)
        PROMPT_PATH="${PROMPT_PATH%/*}/"
    fi
    echo "%{$fg_bold[cyan]%}${PROMPT_PATH}%{$reset_color%}%{$fg[red]%}%1~%{$reset_color%}"
}
