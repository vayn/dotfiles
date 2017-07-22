" Last Change: 2016-12-02T10:06:06
scriptencoding utf-8

" 初始化 Initialization {{{1

set nocompatible

" NeoBundle {{{2

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here: {{{3
NeoBundle 'Shougo/vimproc', {
            \    'build' : {
            \      'windows' : 'make -f make_mingw32.mak',
            \      'cygwin' : 'make -f make_cygwin.mak',
            \      'mac' : 'make -f make_mac.mak',
            \      'unix' : 'make -f make_unix.mak',
            \    },
            \ }

" Vim Document {{{4
NeoBundle 'asins/vimcdoc'
NeoBundle 'powerman/vim-plugin-viewdoc'
" 4}}}

" Utility {{{4
NeoBundle 'CodeFalling/fcitx-vim-osx'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'junegunn/goyo.vim'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'rizzatti/dash.vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'tpope/vim-surround'

" Easy motion {{{5
NeoBundle 'easymotion/vim-easymotion'
NeoBundle 'haya14busa/incsearch.vim'
NeoBundle 'haya14busa/incsearch-easymotion.vim'
" 5}}}

" 4}}}

" Generic Programming Support {{{4
NeoBundle 'davidhalter/jedi-vim', {
            \    'lazy': 1,
            \    'autoload': { 'filetypes': ['python'] }
            \ }
NeoBundle 'honza/vim-snippets'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
" 4}}}

" Aspect Programming Support {{{4

" Git Support
NeoBundle 'tpope/vim-fugitive'

" Web Development Support {{{5
NeoBundle 'ap/vim-css-color'
" WeChat
NeoBundle 'chemzqm/wxapp.vim'
" TypeScript
NeoBundle 'leafgarland/typescript-vim', {
            \    'lazy': 1,
            \    'autoload': { 'filetypes': ['typescript'] }
            \ }
NeoBundle 'Quramy/tsuquyomi', {
            \    'lazy': 1,
            \    'autoload': { 'filetypes': ['typescript'] }
            \ }
" JSX Support
NeoBundle 'mxw/vim-jsx', {
            \   'lazy': 1,
            \   'autoload': { 'filetypes': ['html', 'javascript'] }
            \ }
NeoBundle 'mattn/emmet-vim'
NeoBundle 'othree/jspc.vim'
NeoBundle 'othree/yajs.vim'
" 5}}}

" Rust Support
NeoBundle 'wting/rust.vim', {
            \    'lazy': 1,
            \    'autoload': { 'filetypes': ['rust'] }
            \ }

" Elixir Support {{{5
NeoBundle 'elixir-lang/vim-elixir'
NeoBundle 'avdgaag/vim-phoenix'
NeoBundle 'mmorearty/elixir-ctags'
NeoBundle 'slashmili/alchemist.vim'
" 5}}}

" 4}}}

" Theme / Interface {{{4
NeoBundle 'luochen1990/rainbow'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'morhetz/gruvbox'
" 4}}}

" 3}}}

" All of your Plugins must be added before the following line
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" End: NeoBundle 2}}}

" 自带设置 {{{2
runtime vimrc_example.vim
runtime macros/matchit.vim
" 2}}}

" 工作目录 {{{2
function! ChangeCurrentDir()
    let _dir=escape(expand("%:p:h"),' ')
    exec "cd " . _dir
    unlet _dir
endfunction
autocmd BufEnter * call ChangeCurrentDir()
" 2}}}

" Python 高亮
let python_highlight_all=1

" End: Initialization 1}}}


" 常规设置 Regular Settings {{{1

" Unix 风格 slash
set shellslash
" history 文件记录行数
set history=1000

" 备份 {{{2
set backup
set undofile

if has("win32") || has("win64")
    set backupdir=%TMP%
    set directory=%TMP%
    set undodir=%TMP%
else
    set backupdir=~/.tmp/backup " backups
    set directory=~/.tmp/swap     " swap files
    set undodir=~/.tmp/undodir    " undo
endif

set undolevels=1000
set undoreload=10000 "max number lines to save for undo on a buffer reload
" 2}}}

" 允许backspace和光标键跨越行边界
set whichwrap=b,s,[,],h,l
" 搜索时不区分大小写
set ignorecase
" 搜索高亮
set hlsearch
" 当前 buffer 可放在 bg 而不用写入磁盘
set hidden
" 禁止在选择补全时打开 preview 窗口显示文档信息
" 针对 python omnicomplete（太扰民了）
set completeopt-=preview

set isfname-==
set noequalalways
set winaltkeys=no
set completeopt+=longest
set cedit=<C-Y>

" End: Regular Settings 1}}}


" 格式设置 File Format Settings {{{1

" 编码 {{{2
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1
if has("win32")
    set fileencoding=chinese
else
    set fileencoding=utf-8
endif
language messages zh_CN.utf-8
" 2}}}

" 正确地处理中文字符的折行和拼接
set formatoptions+=mM
" 设置文件格式为unix
set fileformat=unix

" 缩进
set shiftwidth=4
set tabstop=4
set softtabstop=4

" 行间距
if has("gui_macvim")
    set linespace=0
else
    set linespace=4
endif

set expandtab

" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
" 使backspace正常处理indent, eol, start等
set backspace=indent,eol,start
" 在输入命令时列出匹配项目
set wildmenu
set wildmode=list:longest

" Exclude files and directories when expanding wildcards
" MacOSX/Linux
set wildignore+=*/tmp/*,*/.cache/*,*.so,*.swp,*.zip
" Windows
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe

" Indenting
set copyindent
" End: File Format Settings 1}}}


" 显示设置 Interface Settings {{{1

" 字体 Font {{{2
if has('win32') || has('win64')
    set guifont=Source\ Code\ Pro\ 10
elseif has('gui_macvim')
    set guifont=PragmataPro\ for\ Powerline:h13
endif
set ambiwidth=single
" 2}}}

" 窗口及主题设置 Window and theme {{{2
"if !has('gui_running')
    """ 有些终端不能改变大小 http://vayn.de/qF7u2c
    "set lines=30            " 终端出现断裂的原因
    "set columns=85
"endif

set background=dark
colorscheme gruvbox

" 显示状态栏
set laststatus=2
" Hide the default mode text (e.g. -- INSERT -- below the statusline)
set noshowmode
" End: Window and theme 2}}}

" Titlebar 设置 {{{2
set title " Turn on titlebar support

" Set the to- and from-status-line sequences to match the xterm titlebar
" manipulation begin/end sequences for any terminal where
"   a) We don't know for a fact that these sequences would be wrong, and
"   b) the sequences were not already set in terminfo.
" NOTE: This would be nice to fix in terminfo, instead...
if &term !~? '^\v(linux|cons|vt)' && empty(&t_ts) && empty(&t_fs)
  exe "set t_ts=\<ESC>]2;"
  exe "set t_fs=\<C-G>"
endif

"  Titlebar string: hostname> ${PWD:s/^$HOME/~} || (view|vim) filename ([+]|)
"let &titlestring =hostname() . '> ' . '%{expand("%:p:~:h")}'
                "\ . ' || %{&ft=~"^man"?"man":&ro?"view":"vim"} %f %m'
let &titlestring ='%{&ft=~"^man"?"man":&ro?"view":"vim"} %f %m' .
            \ '%{expand("%:p:~:h")}'

" When vim exits and the original title can't be restored, use this string:
if !empty($TITLE)
  " We know the last title set by the shell. (My zsh config exports this.)
  let &titleold=$TITLE
else
  "  Old title was probably something like: hostname> ${PWD:s/^$HOME/~}
  "let &titleold=hostname() . '> ' . fnamemodify($PWD,':p:~:s?/$??')
  let &titleold=fnamemodify($PWD,':p:~:s?/$??')
endif
" End: Titlebar 2}}}

" 高亮光标所在行列
set cursorline
set cursorcolumn
" highlight column after 'textwidth'
set colorcolumn=+1
" highlight three columns after 'textwidth'
set colorcolumn=+1,+2,+3
highlight ColorColumn ctermbg=237 guibg='#3c3836'

" 使用相对行号并显示所在行行号
set number
set relativenumber

" 在终端输出一个相对平滑的更新
set ttyfast
" 在输入括号时光标会短暂地跳到与之相匹配的括号处，不影响输入
set showmatch
" 匹配括号的规则，增加针对html的<>
set matchpairs=(:),{:},[:],<:>
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 不要闪烁
set novisualbell
set listchars=eol:$,tab:>-,nbsp:~
" 自动关闭折叠
set foldclose=all
" 显示窗口末行尽量多的内容
set display=lastline
" 自动回绕
set nolinebreak
" 启动的时候不显示intro
set shortmess=atI
" 屏幕保留行数
set scrolloff=5

" 隐藏底部滚动条
set guioptions-=b
" 隐藏右边滚动条
set guioptions-=R
set guioptions-=r
" 隐藏左边滚动条
set guioptions-=l
set guioptions-=L
" 隐藏菜单和工具栏
set guioptions-=m
set guioptions-=T

" Avoid cmdline redraw on every entered char by turning off Arabic
" shaping (which is implemented poorly).
if has('arabic')
    set noarabicshape
endif

if has("conceal")
    set concealcursor=nc
    set maxcombine=4
endif

" End: Interface Settings 1}}}


" 键映射 Mappings {{{1

" 回车取消搜索高亮
nnoremap <silent> <cr> :nohl<cr>

" 窗口区域切换 ←→↑↓
imap <silent> `h <esc><C-w><left>
vmap <silent> `h <esc><C-w><left>
nmap <silent> `h <C-w><left>
imap <silent> `l <esc><C-w><right>
vmap <silent> `l <esc><C-w><right>
nmap <silent> `l <C-w><right>
imap <silent> `k <esc><C-w><up>
vmap <silent> `k <esc><C-w><up>
nmap <silent> `k <C-w><up>
imap <silent> `j <esc><C-w><down>
vmap <silent> `j <esc><C-w><down>
nmap <silent> `j <C-w><down>

" Use the damn hjkl keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" And make them fucking work, too.
nnoremap j gj
nnoremap k gk

" Display Highlight Group
nnoremap wh :echo
            \ "highlight<" .
            \ synIDattr(synID(line("."), col("."), 1), "name") .
            \ '> trans<' . synIDattr(synID(line("."),col("."),0),"name") .
            \ "> lo<" .
            \ synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name") .
            \ ">"<cr>

nnoremap <BS> d

" 跳转搜索结果时，其所在行居中并闪烁
nnoremap <silent> n nzzzv:call PulseCursorLine()<cr>
nnoremap <silent> N Nzzzv:call PulseCursorLine()<cr>

" ctrl + c
vmap <C-c> "+y
" ctrl + x
vmap <C-x> "+x
" ctrl + v
nnoremap <C-v> "+gP
" ctrl + h
imap <C-h> <esc>:%s/
vmap <C-h> <esc>:%s/
nmap <C-h> :%s/

" Make selecting inside an HTML tag less dumb
nnoremap Vit vitVkoj
nnoremap Vat vatV
" ci[ 删除一对 [] 中的所有字符并进入插入模式
" ci( 删除一对 () 中的所有字符并进入插入模式
" ci< 删除一对 <> 中的所有字符并进入插入模式
" ci{ 删除一对 {} 中的所有字符并进入插入模式
" cit 删除一对 HTML/XML 的标签内部的所有字符并进入插入模式
" ci” ci’ ci` 删除一对引号字符 (” 或 ‘ 或 `) 中所有字符并进入插入模式

" 交换历史移动键位，键位作用参见 cmdline.txt
cnoremap <C-p> <up>
cnoremap <C-n> <down>
cnoremap <up> <C-p>
cnoremap <down> <C-n>

" End: Mappings 1}}}


" Leader Mappings {{{1
let mapleader=","

" strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr>
" imitates TextMates Ctrl+Q function to re-hardwrap paragraphs of text
nnoremap <leader>q gqip
" CSS properties sorted
nnoremap <leader>S /{<cr>jV/^\s*\}\?$<cr>k:sort<cr>:noh<cr>

" Edit vim stuff.
nnoremap <leader>ev :call EditVimRC()<cr>

" Full-screen, wide-margins, no distractions
nnoremap <Leader>f :set fuoptions=maxvert fu<cr>

" open a new vertical split and switch over to it
nnoremap <leader>w <C-w>v<C-w>l

" 让选中内容变成搜索项
vnoremap <Leader># "9y?<C-r>='\V'.substitute(escape(@9,'\?'),'\n','\\n','g')<cr><cr>
vnoremap <Leader>* "9y/<C-r>='\V'.substitute(escape(@9,'\/'),'\n','\\n','g')<cr><cr>

" End: Leader Mappings 2}}}


" 自动命令 Autocmds {{{1

" 设默认 filetype 为 txt
autocmd BufEnter * if &filetype == "" | setlocal ft=txt | endif

" Tsuquyomi plugin
autocmd FileType typescript setlocal completeopt+=menu,preview

" End: Autocmds 1}}}


" 自定义函数 Custom Functions {{{1

" Pulse {{{2
" 来自 http://vayn.de/tUAYAK
function! PulseCursorLine()
    let current_window=winnr()

    windo set nocursorline
    execute current_window . 'wincmd w'

    setlocal cursorline

    redir => old_hi
        silent execute 'highlight CursorLine'
    redir END
    let old_hi=split(old_hi, '\n')[0]
    let old_hi=substitute(old_hi, 'xxx', '', '')

    highlight CursorLine guibg=#2a2a2a ctermbg=233
    redraw
    sleep 20m

    highlight CursorLine guibg=#333333 ctermbg=235
    redraw
    sleep 20m

    highlight CursorLine guibg=#3a3a3a ctermbg=239
    redraw
    sleep 20m

    highlight CursorLine guibg=#444444 ctermbg=240
    redraw
    sleep 20m

    highlight CursorLine guibg=#4a4a4a ctermbg=242
    redraw
    sleep 20m

    highlight CursorLine guibg=#444444 ctermbg=240
    redraw
    sleep 20m

    highlight CursorLine guibg=#3a3a3a ctermbg=239
    redraw
    sleep 20m

    highlight CursorLine guibg=#333333 ctermbg=235
    redraw
    sleep 20m

    highlight CursorLine guibg=#2a2a2a ctermbg=233
    redraw
    sleep 20m

    execute 'highlight ' . old_hi

    windo set cursorline
    execute current_window . 'wincmd w'
endfunction
" End: Pulse 2}}}

" EditVimRC {{{2
function! EditVimRC()
    if argc() > 0
        topleft vertical new
        redraw
    endif
    edit $MYVIMRC
endfunction
" 2}}}

" End: Custom Functions 1}}}


" 插件 Plugins {{{1

" CtrlP {{{2
let g:ctrlp_show_hidden=1
let g:ctrlp_custom_ignore={
            \ 'dir':  '\v[\/]\.(git|hg|svn|idea)$',
            \ 'file': '\v\.(exe|so|dll|DS_Store)$',
            \ 'link': '',
            \ }
" 2}}}


" Dash {{{2
nmap <silent> <Leader>d <Plug>DashSearch
" 2}}}

" Emmet-vim {{{2
let g:user_emmet_leader_key='<C-e>'

let g:user_emmet_settings = {
\ 'wxss': {
\   'extends': 'css',
\ },
\ 'wxml': {
\   'extends': 'html',
\   'aliases': {
\     'div': 'view',
\     'span': 'text',
\   },
\  'default_attributes': {
\     'block': [{'wx:for-items': '{{list}}','wx:for-item': '{{item}}'}],
\     'navigator': [{'url': '', 'redirect': 'false'}],
\     'scroll-view': [{'bindscroll': ''}],
\     'swiper': [{'autoplay': 'false', 'current': '0'}],
\     'icon': [{'type': 'success', 'size': '23'}],
\     'progress': [{'precent': '0'}],
\     'button': [{'size': 'default'}],
\     'checkbox-group': [{'bindchange': ''}],
\     'checkbox': [{'value': '', 'checked': ''}],
\     'form': [{'bindsubmit': ''}],
\     'input': [{'type': 'text'}],
\     'label': [{'for': ''}],
\     'picker': [{'bindchange': ''}],
\     'radio-group': [{'bindchange': ''}],
\     'radio': [{'checked': ''}],
\     'switch': [{'checked': ''}],
\     'slider': [{'value': ''}],
\     'action-sheet': [{'bindchange': ''}],
\     'modal': [{'title': ''}],
\     'loading': [{'bindchange': ''}],
\     'toast': [{'duration': '1500'}],
\     'audio': [{'src': ''}],
\     'video': [{'src': ''}],
\     'image': [{'src': '', 'mode': 'scaleToFill'}],
\   }
\ },
\}
" 2}}}

" Goyo {{{2
nnoremap <leader>go :Goyo<cr>
" 2}}}

" jedi-vim {{{2
let g:jedi#auto_vim_configuration=0
let g:jedi#completions_enabled=0
let g:jedi#force_py_version=3
let g:jedi#smart_auto_mappings=0

" The reason to deactivate jedi#auto_vim_configuration
au FileType python setlocal completeopt-=preview
" 2}}}

" Indent-Guides {{{2
let g:indent_guides_guide_size=1
" 2}}}

" Neocomplete {{{2
" Disable AutoComplPop.
let g:acp_enableAtStartup=0
" Use neocomplete.
let g:neocomplete#enable_at_startup=1
" Use smartcase.
let g:neocomplete#enable_smart_case=1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length=3
let g:neocomplete#lock_buffer_name_pattern='\*ku\*'

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns={}
endif
let g:neocomplete#keyword_patterns['default']='\h\w*'

" Recommended key-mappings.
" <cr>: close popup and save indent.
inoremap <silent> <cr> <C-r>=<SID>my_cr_function()<cr>
function! s:my_cr_function()
    return neocomplete#close_popup() . "\<cr>"
    " For no inserting <cr> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<cr>"
endfunction
" <TAB>: completion.
inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<tab>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><bs> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><C-e> neocomplete#cancel_popup()

" Enable heavy omni completion.
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns={}
endif
let g:neocomplete#force_omni_input_patterns.rust='[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:neocomplete#force_omni_input_patterns.python='\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
let g:neocomplete#force_omni_input_patterns.typescript='[^. *\t]\.\w*\|\h\w*::'
let g:neocomplete#force_omni_input_patterns.elixir='[^. *\t]\.\w*\|[a-zA-Z_]\w*::'

" Enable omni completion. {{{3
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" Use jedi omni completion for Python
autocmd FileType python setlocal omnifunc=jedi#completions
autocmd FileType typescript set omnifunc=tsuquyomi#complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType elixir setlocal omnifunc=elixircomplete#Complete
" 3}}}

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries={
            \ 'default': '',
            \ 'css': '~/.vim/dict/css.dict',
            \ 'javascript': '~/.vim/dict/vim-node-dict/dict/node.dict, ~/.vim/dict/javascript.dict',
            \ }

" End: Neocomplete 2}}}

" NeoSnippet {{{2
" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
    set conceallevel=0 concealcursor=i
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility=1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory="~/.vim/bundle/vim-snippets/snippets"

" Specifies directory for neosnippet cache
let g:neosnippet#data_directory="~/.cache/neosnippet"

" End: Neosnippet 2}}}

" NerdTree {{{2
let NERDTreeQuitOnOpen=1
autocmd StdinReadPre * let s:std_in=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&
            \ b:NERDTreeType == "primary") | q | endif
nnoremap <leader>t :NERDTreeToggle<cr>
" 2}}}

" Rainbow {{{2
let g:rainbow_active = 1 " 0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
\   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'tex': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\       },
\       'lisp': {
\           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\       },
\       'vim': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\       },
\       'html': {
\           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\       },
\       'css': 0,
\   }
\}
" End: Rainbow 2}}}

" viewdoc {{{2
let g:no_viewdoc_maps=1
let g:viewdoc_open="topleft new"
let g:viewdoc_copy_to_search_reg=1

" Patch for viewdoc mappings
if g:viewdoc_copy_to_search_reg
    inoremap <silent> <unique> <F1>  <C-O>:let @/ = '\<'.expand('<cword>').'\>'<CR><C-O>:call ViewDoc('new', '<cword>')<cr><cr>
    nnoremap <silent> <unique> <F1>  :let @/ = '\<'.expand('<cword>').'\>'<CR>:call ViewDoc('new', '<cword>')<cr><cr>
    nnoremap <silent> <unique> K     :let @/ = '\<'.expand('<cword>').'\>'<CR>:call ViewDoc('doc', '<cword>')<cr><cr>
else
    inoremap <silent> <unique> <F1>  <C-O>:call ViewDoc('new', '<cword>')<cr><cr>
    nnoremap <silent> <unique> <F1>  :call ViewDoc('new', '<cword>')<cr><cr>
    nnoremap <silent> <unique> K     :call ViewDoc('doc', '<cword>')<cr><cr>
endif
" End: viewdoc 2}}}

" vim-airline {{{2
let g:airline_powerline_fonts=1
let g:Powerline_symbols="fancy"
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline#extensions#default#layout=[
            \ [ 'a', 'b', 'c' ],
            \ [ 'x', 'y', 'z', 'error', 'warning' ]
            \ ]
if !exists('g:airline_powerline_fonts')
    let g:airline_left_sep='>'
    let g:airline_right_sep='<'
endif
" 2}}}

" vim-easy-align {{{2

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" 2}}}

" vim-jsx {{{2
let g:jsx_ext_required=0
" 2}}}

" vim-alchemist {{{2
autocmd FileType elixir nnoremap <buffer> <leader>h :call alchemist#exdoc()<CR>
autocmd FileType elixir nnoremap <buffer> <leader>d :call alchemist#exdef()<CR>
" 2}}}

" Easy motion {{{2
" incsearch {{{3
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" 3}}}

" incsearch-easymotion {{{3
map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)
" 3}}}

" 2}}}

" End: Plugins 1}}}

" vim:fdm=marker
