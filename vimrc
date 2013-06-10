" .vimrc
" Author: Philipe Fatio <me@phili.pe>

" Preamble                                                                   {{{

" Use vim settings, rather then vi settings (much better!)
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off
set encoding=utf-8

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" }}}
" Bundles                                                                    {{{

Bundle 'Lokaltog/vim-easymotion'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'altercation/vim-colors-solarized'
Bundle 'chriskempson/base16-vim'
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'croaky/vim-colors-github'
Bundle 'gmarik/vundle'
Bundle 'kana/vim-textobj-user'
Bundle 'kana/vim-smartinput'
Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'
Bundle 'matchit.zip'
Bundle 'mileszs/ack.vim'
Bundle 'ap/vim-css-color'
Bundle 'nelstrom/vim-markdown-folding'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'rainbow_parentheses.vim'
Bundle 'ruby-matchit'
Bundle 'ryan-cf/netrw'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdcommenter'
Bundle 'SirVer/ultisnips'
Bundle 'sjl/gundo.vim'
Bundle 'slim-template/vim-slim'
Bundle 'tomtom/tlib_vim'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tsaleh/vim-align'
Bundle 'vim-coffee-script'
Bundle 'tpope/vim-dispatch'
Bundle 'jgdavey/vim-turbux'
Bundle 'vim-ruby/vim-ruby'
Bundle 'sjl/vitality.vim'
Bundle 'LnL7/vim-tslime'
Bundle 'christoomey/vim-tmux-navigator'

" }}}
" Editing Behavior                                                           {{{

syntax on                       " enable syntax highlighting
filetype plugin indent on
set showmode                    " always show what mode we're currently editing in
set nowrap                      " don't wrap lines
set tabstop=2                   " a tab is two spaces
set softtabstop=2               " when hitting <BS>, pretend like a tab is removed, even if spaces
set shiftwidth=2                " number of spaces to use for autoindenting
set expandtab                   " use spaces
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
if v:version >= 703
  set relativenumber            " use relative line numbers
else
  set number                    " use absolute line numbers
endif
set showmatch                   " set show matching parenthesis
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
                                "   case-sensitive otherwise
set splitright                  " open vertical splits to the right
set splitbelow                  " open splits to the bottom
set cursorline                  " highlight current line
set smarttab                    " insert tabs on the start of a line according to
                                "   shiftwidth, not tabstop
set scrolloff=2                 " keep x lines off the edges of the screen when scrolling vertically
set sidescrolloff=2             " keep x columns off the edges of the screen when scrolling horizontally
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set gdefault                    " search/replace "globally" (on a line) by default
set listchars=tab:▸\ ,trail:·,extends:…,nbsp:·
set list                        " show above special chars
set showbreak=↪ 
set pastetoggle=<F2>            " when in insert mode, press <F2> to go to
                                "   paste mode, where you can paste mass data
                                "   that won't be autoindented
set t_Co=256                    " Explicitly tell that the terminal has 256 colors

" suppress all bells
set novisualbell
set noerrorbells
set vb

set mouse=a                     " enable using the mouse if terminal emulator
                                "    supports it (xterm does)
set fileformats="unix,dos,mac"

set textwidth=80
set formatoptions=1cjnqro

set hidden                      " hide buffers instead of closing them this
                                "    means that the current buffer can be put
                                "    to background without being written; and
                                "    that marks and undo history are preserved
set switchbuf=useopen           " reveal already opened files from the
                                " quickfix window instead of opening new
                                " buffers
set history=1000                " remember more commands and search history
set undolevels=1000             " use many muchos levels of undo
if v:version >= 730
    set undofile                " keep a persistent backup file
    set undodir=~/.vim/.undo,~/tmp,/tmp
endif
set nobackup                    " do not keep backup files, it's 70's style cluttering
set noswapfile                  " do not write annoying intermediate swap files,
                                "    who did ever restore from swap files anyway?
set directory=~/.vim/.tmp,~/tmp,/tmp
                                " store swap files in one of these directories
                                "    (in case swapfile is ever turned on)
set viminfo='20,\"80            " read/write a .viminfo file, don't store more
                                "    than 80 lines of registers
set title                       " change the terminal's title
set showcmd                     " show (partial) command in the last line of the screen
                                "    this also shows visual selection info
set nomodeline                  " disable mode lines (security measure)

set ruler                       " show cursor position
set colorcolumn=81              " highlight 81st column

" Tab completion
set wildmode=list:longest,list:full
set wildmenu
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,doc/**,coverage/**

set laststatus=2                " Always display the statusline in all windows
set noshowmode                  " Hide the default mode text (e.g. -- INSERT -- below the statusline)

set spell
set spelllang=en_us

" LaTeX settings
set cole=2
let g:tex_conceal='adgm'
hi Conceal guibg=bg guifg=#66d9ef

au FocusLost,TabLeave * :silent! wa     " TextMate style save on focus lost

" }}}
" Key Mappings                                                               {{{

" The current directory for the active file
cnoremap %% <C-R>=expand('%:h').'/'<CR>

map <leader>q <ESC>:q<CR>
imap <leader>q <ESC>:q<CR>
map <leader>w <ESC>:w<CR>
imap <leader>w <ESC>:w<CR>
map <leader>wq <ESC>:wq<CR>
imap <leader>wq <ESC>:wq<CR>

" turn off highlighting
nnoremap <leader><space> :noh<cr>

" Thanks to Steve Losh for this liberating tip
" See http://stevelosh.com/blog/2010/09/coming-home-to-vim
nnoremap / /\v
vnoremap / /\v

" make j and k always move to next visual line (useful for wrapped lines).
nnoremap j gj
nnoremap k gk

" clean whitespace in file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" fold tag in HTML
nnoremap <leader>ft Vatzf

" navigate around split windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Keep search matches in the middle of the window and open the fold.
nnoremap * *zvzz
nnoremap ? ?zvzz
nnoremap n nzvzz
nnoremap N Nzvzz

" Same behavior as C
nnoremap D d$
nnoremap Y y$

" Ack
nnoremap <leader>f :Ack<space>

" toggle fold
nnoremap <Space> za
vnoremap <Space> za
" "Refocus" folds
nnoremap <leader>z zMzvzczOzz

" Yank/paste to the OS clipboard with ,y and ,p
nmap <leader>y "*y
nmap <leader>Y "*yy
nmap <leader>p "*p
nmap <leader>P "*P
vmap <leader>y "*y
vmap <leader>p "*p

" Make Arrow Keys Useful Again
map <down> <ESC>:cn<CR>zz
map <S-down> <ESC>:cnewer<CR>
map <up> <ESC>:cp<CR>zz
map <S-up> <ESC>:colder<CR>
map <right> <ESC>:TagbarToggle<CR>
map <S-right> <ESC>:GundoToggle<CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" return in the middle of a line
imap <C-CR> <ESC>o
" go to insert with an empty line above and below
nmap <C-CR> ]<space>o

" highlight lines longer than 80 chars
nnoremap <leader>ll /\%>80v.\+<CR>

" Adjust viewports to the same size
map <Leader>= <C-w>=

" open ControlP in tag mode
map <C-t> :CtrlPTag<CR>

" Quickly open certain files for editing
map <leader>ev :tabe ~/.vim/vimrc<CR>:lcd %:p:h<CR>
map <leader>em :tabe ~/.vimmnemonics<CR>
map <leader>es :tabe<CR>:UltiSnipsEdit<CR>:lcd %:p:h<CR>

" Quickly call fugitive stuff
map <leader>gs :Gstatus<CR>
map <leader>gS :Gtabedit :<CR>
map <leader>gd :Gdiff<CR>
" When diffing two files, save the one on the left, close it, go to the git
" status split below and jump to the next file:
map <leader>gn <C-w>h:wq<CR><C-w>j<C-n>

" }}}
" Folding Rules                                                              {{{

set nofoldenable
set foldcolumn=0
set foldmethod=syntax
set foldlevelstart=99
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
                                " which commands trigger auto-unfold

function! MyFoldText()
    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)

    let start_line = substitute(getline(v:foldstart), '\t', onetab, 'g')
    let delta = 0 " unicode char correction
    if len(start_line) > 72
      let start_line = substitute(start_line, '^\(.\{72\}\).*$', '\1…', 'g')
      let delta = 2
    endif

    let end_line = substitute(getline(v:foldend), '\s', '', 'g')

    let nucolwidth = &foldcolumn + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart + 1

    let line = start_line.'  '
    let dash_fill_count = windowwidth - 80
    let space_fill_count = 80 - len(line) - len(foldedlinecount) - 1 + delta

    return line.repeat(' ', space_fill_count).foldedlinecount.' '.repeat('—', dash_fill_count)
endfunction
set foldtext=MyFoldText()

function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction
nmap <silent> zj :call NextClosedFold('j')<cr><leader>z
nmap <silent> zk :call NextClosedFold('k')<cr><leader>z

" }}}
" Plugins Configuration                                                      {{{

" Netrw
let g:netrw_liststyle=3
let g:netrw_browsex_viewer="open"
let g:netrw_list_hide='^\(\.bundle\/\|\.sass-cache\/\|\.DS_Store\|\.git\/\|Build\/\|.*\.xcodeproj\/\|.*xcworkspace\/\)$'

" Tagbar
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1

" Syntastic
let g:syntastic_java_javac_args="-classpath /usr/local/Cellar/hadoop/1.1.1/libexec/hadoop-core-1.1.1.jar"

" CTags
map <leader>ct :!/usr/local/bin/ctags --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>

" add a definition for Objective-C to tagbar
let tlist_objc_settings = 'ObjectiveC;P:protocols;i:interfaces;types(...)'
let g:tagbar_type_objc = {
    \ 'ctagstype' : 'ObjectiveC',
    \ 'kinds'     : [
        \ 'i:interface',
        \ 'I:implementation',
        \ 'p:Protocol',
        \ 'm:Object_method',
        \ 'c:Class_method',
        \ 'v:Global_variable',
        \ 'F:Object field',
        \ 'f:function',
        \ 'p:property',
        \ 't:type_alias',
        \ 's:type_structure',
        \ 'e:enumeration',
        \ 'M:preprocessor_macro',
    \ ],
    \ 'sro'        : ' ',
    \ 'kind2scope' : {
        \ 'i' : 'interface',
        \ 'I' : 'implementation',
        \ 'p' : 'Protocol',
        \ 's' : 'type_structure',
        \ 'e' : 'enumeration'
    \ },
    \ 'scope2kind' : {
        \ 'interface'      : 'i',
        \ 'implementation' : 'I',
        \ 'Protocol'       : 'p',
        \ 'type_structure' : 's',
        \ 'enumeration'    : 'e'
    \ }
\ }

" Powerline
set rtp+=~/.virtualenv/default_env/lib/python2.7/site-packages/powerline/bindings/vim/

" ControlP
let g:ctrlp_extensions = ['tag']
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn|sass-cache|bundle)|build|tmp|bin)$',
  \ 'file': '\v\.(exe|so|dll|DS_Store)$',
  \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
  \ }
let g:ctrlp_cmd = 'CtrlPCurWD'

let g:gundo_right = 1

let g:turbux_command_rspec = 'rspec -fp --drb'
let g:no_turbux_mappings = 1
" Rspec file
map <leader>rf <Plug>SendTestToTmux
" Rspec line
map <leader>rl <Plug>SendFocusedTestToTmux
" Rspec format doc
map <leader>rd :<C-U>w \| call SendToTmux("rspec --drb -fd ".expand("%")."\n")<CR>
" Rspec line
map <leader>ra :<C-U>w \| Dispatch rspec --drb<CR>
" Rspec all format doc
map <leader>rad :<C-U>w \| call SendToTmux("rspec --drb -fd\n")<CR>
" Dispatch
map <leader>d :Dispatch<space>
" Tx
map <leader>tx :Tx<space>

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" }}}
" Editor Behavior                                                            {{{

set autoread                  " Remember last location in file
set timeoutlen=600            " timeout for leader maps

au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal g'\"" | endif

let g:solarized_contrast='high'
let g:solarized_visibility='high'

if ! has('gui_running')
  set bg=dark
  colorscheme base16-eighties
else
  set bg=dark
  colorscheme base16-eighties
  set ttimeoutlen=10
  augroup FastEscape

    autocmd!
    au! InsertEnter * set timeoutlen=0
    au! InsertLeave * set timeoutlen=1000
  augroup END
endif

" }}}
" File Type Configurations                                                   {{{

au FileType javascript,css,less,scss,objc,c,vim setlocal foldmethod=marker
au FileType javascript,css,less,scss,objc,c setlocal foldmarker={,}
au FileType coffee setlocal foldmethod=indent

au FileType scss setlocal iskeyword+=@-@,$,-,%,#,.
au FileType css setlocal iskeyword+=-,#,.
au FileType coffee setlocal iskeyword+=$

au FileType gitcommit setlocal formatoptions+=a
au FileType gitcommit setlocal textwidth=72
au FileType gitcommit setlocal colorcolumn=51

au FileType make,snippets setlocal noexpandtab
au FileType objc setlocal shiftwidth=4

" Delete certain buffers in order to not cluttering up the buffer list:
au BufReadPost fugitive://* set bufhidden=delete
au BufReadPost ~/.rbenv/* set bufhidden=delete

au BufNewFile,BufRead {Gem,Pod,Rake}file,*.{rabl,podspec} set filetype=ruby
au BufNewFile,BufRead *_spec.rb set filetype=rspec.ruby

" }}}

