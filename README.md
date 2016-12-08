#dotfiles

All related dotfiles on my MacOS and Linux.

## Installation

You can install this via the command-line with either `curl` or `wget`.

### via curl

```shell
sh -c "$(curl -fsSL https://coding.net/u/vayn/p/dotfiles/git/raw/master/install.sh)"
```

### via wget

```shell
sh -c "$(wget https://coding.net/u/vayn/p/dotfiles/git/raw/master/install.sh -O -)"
```

After installing dotfiles, you should install Vim plugins with NeoBundle:

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh)"
vim +NeoBundleInstall +qall
```

## Acknowledgement

[Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh)

