###
# My zsh configuration
###

# 设置 Config {{{1

# 立即打印 job 状态
setopt notify
# 不需要打 cd，直接进入目录
setopt autocd
# 自动记住已访问目录栈
setopt auto_pushd
setopt pushd_ignore_dups
# rm * 时不要提示
setopt rmstarsilent
# 允许在交互模式中使用注释
setopt interactive_comments
# disown 后自动继续进程
setopt auto_continue
setopt extended_glob
# 单引号中的 '' 表示一个 ' （如同 Vimscript 中者）
setopt rc_quotes
# 补全列表不同列可以使用不同的列宽
setopt listpacked
# 为方便复制，右边的提示符只在最新的提示符上显示
setopt transient_rprompt
# setopt 的输出显示选项的开关状态
setopt ksh_option_print
# 与 stty -ixon 效果一样
setopt noflowcontrol

# 历史记录 {{{2
# 如果连续输入的命令相同，历史记录中只保留一个
setopt HISTIGNOREDUPS
# 不保留重复的历史记录项
setopt hist_ignore_all_dups
# 在命令前添加空格，不将此命令添加到记录文件中
setopt hist_ignore_space
# Allow for functions in the prompt.
setopt prompt_subst
# 2}}}

# 命令行编辑 Commandline {{{2
bindkey -e
bindkey "^U" backward-kill-line
bindkey "^]" vi-find-next-char
bindkey "^[]" vi-find-prev-char
# Alt-W 删除 path 的部分
bindkey "^[w" vi-backward-kill-word
bindkey "^[[3~" delete-char
# ^J 保持当前命令行但不执行
bindkey -s "^J" "^[[A^[[B"
bindkey -s "^[[Z" "^P"
bindkey '^Xa' _expand_alias
# ^Xe 用$EDITOR编辑命令
autoload edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line
bindkey '^[/' _history-complete-older
# 用单引号引起最后一个单词
# FIXME 如何引起光标处的单词？
bindkey -s "^['" "^[] ^f^@^e^[\""

# look for a command that started like the one starting on the command line {{{3
# http://www.xsteve.at/prg/zsh/.zshrc
function history-search-end {
  integer ocursor=$CURSOR

  if [[ $LASTWIDGET = history-beginning-search-*-end ]]; then
  # Last widget called set $hbs_pos.
  CURSOR=$hbs_pos
  else
  hbs_pos=$CURSOR
  fi

  if zle .${WIDGET%-end}; then
  # success, go to end of line
  zle .end-of-line
  else
  # failure, restore position
  CURSOR=$ocursor
  return 1
  fi
}
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end
# 3}}}

# 词界像 bash 那样{{{3
#autoload -U select-word-style
#select-word-style bash
# 3}}}

# Esc-Esc 在当前/上一条命令前插入 sudo {{{3
sudo-command-line() {
  [[ -z $BUFFER ]] && zle up-history
  [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
  zle end-of-line         #光标移动到行末
}
zle -N sudo-command-line
bindkey "\e\e" sudo-command-line
# 3}}}

# End: Commandline 2}}}

# End: Config 1}}}


# Completion {{{1

# 用本用户的所有进程补全
[[ -n $commands[trimdir] ]] && zstyle ':completion:*:processes' command 'ps -afu$USER|trimdir' || zstyle ':completion:*:processes' command 'ps -afu$USER'
zstyle ':completion:*:*:*:*:processes' force-list always
# 进程名补全
zstyle ':completion:*:processes-names' command  'ps c -u ${USER} -o command | uniq'

# 警告显示为红色
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
# 描述显示为淡色
zstyle ':completion:*:descriptions' format $'\e[2m -- %d --\e[0m'
zstyle ':completion:*:corrections' format $'\e[01;33m -- %d (errors: %e) --\e[0m'

# cd 补全顺序
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
# 在 .. 后不要回到当前目录
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:man:*' separate-sections true

zstyle ':completion:*' menu select
# 分组显示
zstyle ':completion:*' group-name ''
# 模糊匹配
# 在最后尝试使用文件名
zstyle ':completion:*' completer _complete _match _approximate _ignored _files
# 修正大小写
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
# 使用缓存。某些命令的补全很耗时的（如 aptitude）
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle -e ':completion:*' special-dirs \
  '[[ $PREFIX == (../)#(|.|..) ]] && reply=(..)'

# End: Completion 1}}}


# My completion {{{1
zstyle ':completion:*:*:x:*' file-patterns \
'*.{7z,bz2,gz,rar,tar,tbz,tgz,zip,chm,xz}:compressed\ files *(-/):directories'
zstyle ':completion:*:*:evince:*' file-patterns \
'*.{pdf,ps,eps,dvi,pdf.gz,ps.gz,dvi.gz}:Documents *(-/):directories'
zstyle ':completion:*:*:gbkunzip:*' file-patterns '*.zip'
zstyle ':completion:*:*:luit:*' file-patterns '*(*)'

# ^X-Tab 在任何地方都补全文件名
# http://stackoverflow.com/questions/2658534/bind-key-to-complete-filename-wherever-the-context-is-in-zsh
zle -C complete complete-word complete-files
bindkey "^X\t" complete
complete-files () { _files $@ }
# End: My Completion 1}}}


# Alias {{{1

# 命令别名 {{{2
alias :q='exit'
alias ll='ls -lh'
alias la='ls -A'
alias ....='../..'
alias ......='../../..'
alias zshrc="vim ~/.zshrc"
alias ren="vim +'Ren'"
alias grep='grep --color=auto'
alias resetdock="defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock"

# 查看进程数最多的程序
alias topnum="ps -e|sort -k4|awk '{print \$4}'|uniq -c|sort -n|tail"

alias rebootrt="wget --user=admin --password=admin888 'http://192.168.1.1/userRpm/SysRebootRpm.htm?Reboot=%D6%D8%C6%F4%C2%B7%D3%C9%C6%F7' -O /dev/null"
alias pm-suspend="dbus-send --system --print-reply --dest=org.freedesktop.Hal /org/freedesktop/Hal/devices/computer org.freedesktop.Hal.Device.SystemPowerManagement.Suspend int32:0"
alias wsite="wget -t 5 -Q 500m -nH -r -E -l inf -k -p -np"

# OSX预览文件
alias preview="qlmanage -p &> /dev/null"
# 2}}}

# 后缀别名 {{{2
alias -s xsl="vim"
alias -s {html,htm}="firefox"
alias -s {pdf,ps}="evince"
alias -s ttf="gnome-font-viewer"
alias -s {png,jpg,gif}="feh"
alias -s jar="java -jar"
alias -s swf="flashplayer"
# 2}}}

# 全局别名 {{{2
alias -g LS="|less"
# 当前目录下最后修改的文件
# 来自 http://roylez.heroku.com/2010/03/06/zsh-recent-file-alias.html
alias -g NN="*(oc[1])"
alias -g NUL="/dev/null"
# 2}}}

# End: Alias 1}}}

# Functions {{{1
vman () { vim +"set ft=man" +"Man $@" }
nocolor () { sed -r "s:\x1b\[[0-9;]*[mK]::g" }
expandurl() { curl -sIL $1 | sed -n 's/Location:.* //p' }

ptyless () { # 使用伪终端代替管道，对 ls 这种“顽固分子”有效 {{{2
  zmodload zsh/zpty
  zpty ptyless ${1+"$@"}
  zpty -r ptyless > /tmp/ptyless.$$
  less /tmp/ptyless.$$
  rm -f /tmp/ptyless.$$
  zpty -d ptyless
} # 2}}}

sdu () { #排序版的 du {{{2
  du -sk $@ | sort -n | awk '
BEGIN {
  split("K,M,G,T", Units, ",");
  FS="\t";
  OFS="\t";
}
{
  u = 1;
  while ($1 >= 1024) {
  $1 = $1 / 1024;
  u += 1
  }
  $1 = sprintf("%.1f%s", $1, Units[u]);
  sub(/\.0/, "", $1);
  print $0;
}'
} # 2}}}

pid () { #{{{2
  s=0
  for i in $@; do
  echo -n "$i: "
  r=`cat /proc/$i/cmdline|tr '\0' ' ' 2>/dev/null`
  if [[ $? -ne 0 ]]; then
    echo not found
    s=1
  else
    echo $r
  fi
  done
  return $s
} # 2}}}

s () { # 快速查找当前目录下的文件 {{{2
  name=$1
  shift
  find . -name "*$name*" $@
} # 2}}}

color-blocks () { #Color blocks {{{2
  echo
  local width=$(( ($COLUMNS / 16) -1 ))
  local chars
  local pre=$(( ( $COLUMNS - ($width+1)*16)/2 ))
  for ((i=0; i<$width; i++)); chars+="░"
  for ((i=0; i<$pre; i++)); echo -n " "
  for ((i=0; i<=7; i++)); echo -en "\e[3${i}m${chars} \e[1;3${i}m${chars}\e[m "; echo; echo
  unset i
} # 2}}}

code () { #VSCode {{{2
  VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;
} # 2}}}

# End: Functions 1}}}

# 插件 My Plugins {{{1

# Autojump {{{2
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
# 2}}}

# Set tab title {{{2
source $ZSH_LEGACY/plugins/set-title-tab.zsh
# 2}}}

# Directory-history {{{2
source $ZSH_LEGACY/plugins/directory-history/directory-history.plugin.zsh
source $ZSH_LEGACY/plugins/directory-history/zsh-history-substring-search.zsh

# Bind CTRL+k and CTRL+j to substring search
bindkey '^j' history-substring-search-up
bindkey '^k' history-substring-search-down

# Bind k and j for VI mode to go through history
bindkey -M vicmd 'j' directory-history-search-backward
bindkey -M vicmd 'k' directory-history-search-forward
# 2}}}

# color-dir-name {{{2
source $ZSH_LEGACY/plugins/color-dir-name.zsh
# 2}}}

# virtualenvwrapper {{{2
source $ZSH_LEGACY/plugins/virtualenvwrapper.plugin.zsh
# 2}}}

# gruvbox theme {{{2
source $ZSH_LEGACY/plugins/gruvbox.zsh
# 2}}}

# End: My plugins 1}}}


# Constants {{{1

# Rust 设置 {{{2
export RUST_SRC_PATH=/usr/local/src/rust/src
# 2}}}

# virtualenvwrapper 设置 {{{2
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh
# 2}}}


# For Homebrew {{{2
export PATH="/usr/local/sbin:$PATH"
# 2}}}

# End: Constants 1}}}

return 0

