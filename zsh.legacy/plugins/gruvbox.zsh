# OS detection
[[ -n "${OS}" ]] || OS=$(uname)
unsetopt nomatch

if [ $OS = "Darwin" ]; then
  [ -f "${HOME}/.vim/bundle/gruvbox/gruvbox_256palette_osx.sh" ] && {
    source "${HOME}/.vim/bundle/gruvbox/gruvbox_256palette_osx.sh"
  }
fi

unset OS
unsetopt nomatch
