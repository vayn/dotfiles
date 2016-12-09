main() {
    local DOTFILES=~/.dotfiles

    # Use colors, but only if connected to a terminal, and that terminal
    # supports them.
    if which tput >/dev/null 2>&1; then
        ncolors=$(tput colors)
    fi
    if [[ -t 1 ]] && [[ -n $ncolors ]] && [[ $ncolors -ge 8 ]]; then
        RED="$(tput setaf 1)"
        GREEN="$(tput setaf 2)"
        YELLOW="$(tput setaf 3)"
        BLUE="$(tput setaf 4)"
        BOLD="$(tput bold)"
        NORMAL="$(tput sgr0)"
    else
        RED=""
        GREEN=""
        YELLOW=""
        BLUE=""
        BOLD=""
        NORMAL=""
    fi

    # Only enable exit-on-error after the non-critical colorization stuff,
    # which may fail on systems lacking tput or terminfo
    set -e

    local PLATFORM='unknown'
    if which uname >/dev/null 2>&1; then
        unamestr=$(uname)
    else
        printf "${YELLOW}\`uname is not found!${NORMAL} It cannot detect the OS!\n"
    fi
    if [[ "$unamestr" == 'Linux' ]]; then
        PLATFORM='linux'
    elif [[ "$unamestr" == 'FreeBSD' ]]; then
        PLATFORM='freebsd'
    elif [[ "$unamestr" == 'Darwin' ]]; then
        PLATFORM='macos'
    fi

    local CHECK_ZSH_INSTALLED=$(grep /zsh$ /etc/shells | wc -l)
    if [[ ! $CHECK_ZSH_INSTALLED -ge 1 ]]; then
        printf "${YELLOW}Zsh is not installed!${NORMAL} Please install zsh first!\n"
        exit
    fi

    if [[ -d $DOTFILES ]]; then
        printf "${YELLOW}You already have dotfiles installed.${NORMAL}\n"
        printf "You'll need to remove $DOTFILES if you want to re-install.\n"
        exit
    fi

    # Prevent the cloned repository from having insecure permissions. Failing to do
    # so causes compinit() calls to fail with "command not found: compdef" errors
    # for users with insecure umasks (e.g., "002", allowing group writability). Note
    # that this will be ignored under Cygwin by default, as Windows ACLs take
    # precedence over umasks except for filesystems mounted with option "noacl".
    umask g-w,o-w

    printf "${BLUE}Cloning dotfiles...${NORMAL}\n\n"
    hash git >/dev/null 2>&1 || {
        echo "Error: git is not installed"
        exit 1
    }

    env git clone --depth=1 https://git.coding.net/vayn/dotfiles.git $DOTFILES || {
        printf "Error: git clone of dotfiles repo failed\n"
        exit 1
    }

    # Zsh initialization
    local DF_ZSHDIR=$DOTFILES/zsh
    local DF_ZSHRC=$DOTFILES/_zshrc
    init ~/.zshrc $DF_ZSHRC ~/.zsh $DF_ZSHDIR

    # Vim initialization
    local DF_VIMDIR=$DOTFILES/vim
    local DF_VIMRC=$DOTFILES/_vimrc
    init ~/.vimrc $DF_VIMRC ~/.vim $DF_VIMDIR
    if [[ $PLATFORM == 'macos' ]]; then
        init ~/.gvimrc $DOTFILES/_gvimrc
    fi

    # Tmux Initialization
    local DF_TMUXCONF=$DOTFILES/_tmux.conf
    init ~/.tmux.conf $DF_TMUXCONF
}

init() {
    local RC=${1}
    local DF_RC=${2}

    if [[ $# -eq 4 ]]; then
        local DIR=${3}
        local DF_DIR=${4}
    fi

    if [[ -f $RC ]] || [[ -h $RC ]]; then
        printf "${BLUE}Looking for an existing config...${NORMAL}\n"

        printf "${YELLOW}Found $RC${NORMAL}\n"
        printf "${GREEN}Backing up to $RC.pre-dotfiles${NORMAL}\n"
        mv $RC $RC.pre-dotfiles
    fi
    printf "${BLUE}Linking $RC...${NORMAL}\n\n"
    ln -s $DF_RC $RC

    if [[ ! -z $DIR ]]; then
        if [[ -d $DIR ]]; then
            printf "${BLUE}Looking for an existing config directory...${NORMAL}\n"

            printf "${YELLOW}Found $DIR${NORMAL}\n"
            printf "${GREEN}Backing up to $DIR.pre-dotfiles${NORMAL}\n"
            mv $DIR $DIR.pre-dotfiles
        fi

        printf "${BLUE}Linking $DF_DIR...${NORMAL}\n\n"
        ln -s $DF_DIR $DIR
    fi
}

main

printf "${YELLOW}Done.${NORMAL} Now you should use command below to install Vim and Zsh plugins:\n\n"
printf "$ ${RED}pip install zsh-directory-history${NORMAL}\n"
printf "$ ${RED}sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh)\"${NORMAL}\n"
printf "$ ${RED}vim +NeoBundleInstall +qall${NORMAL}\n\n"

