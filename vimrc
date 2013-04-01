""""""""""""""""""""""""""""""""""""""""""""""""
"                                              "
"   Philipe Fatio <philipe.fatio@gmail.com>    "
"                                              "
"   Custom vim config thrown together from     "
"   various sources found mainly on GitHub.    "
"                                              "
""""""""""""""""""""""""""""""""""""""""""""""""

" Basic Config {{{
" Use vim settings, rather then vi settings (much better!)
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off
set encoding=utf-8

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" }}}

" Bundles {{{
Bundle 'tpope/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-bundler'
Bundle 'majutsushi/tagbar'
Bundle 'altercation/vim-colors-solarized'
Bundle 'scrooloose/nerdtree'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'sjl/gundo.vim'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-endwise'
Bundle 'tsaleh/vim-align'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'kana/vim-textobj-user'
Bundle 'tpope/vim-surround'
Bundle 'mileszs/ack.vim'
Bundle 'scroolose/nerdcommenter'
Bundle 'nel/vim-css-color'
Bundle 'Townk/AutoClose'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-git'
Bundle 'matchit.zip'
Bundle 'ruby-matchit'
" Bundle 'cocoa.vim'
" Bundle 'Match-Bracket-for-Objective-C'
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'chriskempson/base16-vim'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-coffee-script'
Bundle 'slim-template/vim-slim'
Bundle 'airblade/vim-gitgutter'
" vim-scripts repos
Bundle 'rainbow_parentheses.vim'
" non github repos
" }}}

" Editing Behaviour {{{
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
set cursorline                  " highlight current line
set smarttab                    " insert tabs on the start of a line according to
                                "   shiftwidth, not tabstop
set scrolloff=4                 " keep 4 lines off the edges of the screen when scrolling
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
let base16colorspace=256
" suppress all bells
set novisualbell
set noerrorbells
set vb

set mouse=a                     " enable using the mouse if terminal emulator
                                "    supports it (xterm does)
set fileformats="unix,dos,mac"
set formatoptions+=1            " When wrapping paragraphs, don't end lines
                                "    with 1-letter words (looks stupid)

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
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,doc/**,coverage/**

set laststatus=2                " Always display the statusline in all windows
set noshowmode                  " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" LaTeX settings
set cole=2
let g:tex_conceal='adgm'
hi Conceal guibg=bg guifg=#66d9ef

au FocusLost,TabLeave * :silent! wa     " TextMate style save on focus lost
" }}}

" Key Mappings {{{
let mapleader="," " Change the mapleader from \ to ,

" turn off highlighting
nnoremap <leader><space> :noh<cr>

nmap <tab> %
vmap <tab> %

" Thanks to Steve Losh for this liberating tip
" See http://stevelosh.com/blog/2010/09/coming-home-to-vim
nnoremap / /\v
vnoremap / /\v

" Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" Disable arrow keys and make j and k always move to next line.
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap j gj
nnoremap k gk

noremap ; :

" clean whitespace in file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" fold tag in HTML
nnoremap <leader>ft Vatzf

" get back to normal mode by typing jj
inoremap jj <ESC>

" faster save and close
nnoremap <leader>w <ESC>:w<CR>
inoremap <leader>w <ESC>:w<CR>
nnoremap <leader>q <ESC>:q<CR>
inoremap <leader>q <ESC>:q<CR>
nnoremap <leader>wq <ESC>:wq<CR>
inoremap <leader>wq <ESC>:wq<CR>

" navigate around split windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Keep search matches in the middle of the window.
nnoremap * *zz
nnoremap ? ?zz
nnoremap n nzz
nnoremap N Nzz

" delete till eol
nnoremap D d$

" Ack
nnoremap <leader>A :Ack 

" toggle fold
nnoremap <leader>f za
vnoremap <leader>f za

" Yank/paste to the OS clipboard with ,y and ,p
nmap <leader>y "*y
nmap <leader>Y "*yy
nmap <leader>p "*p
nmap <leader>P "*P
vmap <leader>y "*y
vmap <leader>p "*p

" space / shift-space scroll in normal mode
noremap <S-space> <C-b>
noremap <space> <C-f>

" Make Arrow Keys Useful Again
map <down> <ESC>:bn<RETURN>
map <up> <ESC>:bp<RETURN>
map <left> <ESC>:NERDTreeToggle<RETURN>
map <right> <ESC>:TagbarToggle<RETURN>

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :tabe $MYVIMRC<CR>
nmap <silent> <leader>sv :silent! so $MYVIMRC<CR>:silent! so $MYGVIMRC<CR>

nnoremap <F5> :GundoToggle<CR>

" fast splitting
map <leader>sh <ESC>:vs<CR>
map <leader>sl <ESC>:vs<CR><C-w>l
map <leader>sk <ESC>:sp<CR>
map <leader>sj <ESC>:sp<CR><C-w>j
" fast splitting to counterpart
map <leader>ah <ESC>:vs<CR>:A<CR>
map <leader>al <ESC>:vs<CR><C-w>l:A<CR>
map <leader>ak <ESC>:sp<CR>:A<CR>
map <leader>aj <ESC>:sp<CR><C-w>j:A<CR>

" return in the middle of a line
imap <C-CR> <ESC>o

" highlight lines longer than 80 chars
nnoremap <leader>ll /\%>80v.\+<CR>

" Adjust viewports to the same size
map <Leader>= <C-w>=
imap <Leader>= <Esc> <C-w>=

" edit snippets
nnoremap <leader>es :SnipMateOpenSnippetFiles<CR>

" create new stuff
nnoremap <leader>nt :tabnew<CR>

" close stuff
nnoremap <leader>ct :tabclose<CR>

" run stuff
map <Leader>r :w<CR>:make<CR>
imap <Leader>r <Esc> :w<CR>:make<CR>

" open ControlP in tag mode
map <C-t> :CtrlPTag<CR>
" open ControlP in pwd
map <C-p> :CtrlPCurWD<CR>
" }}}

" Folding Rules {{{
set foldenable                  " enable folding
set foldcolumn=2                " add a fold column
set foldmethod=marker           " detect triple-{ style fold markers
set foldlevelstart=0            " start out with everything folded
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
                                " which commands trigger auto-unfold
function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . ' …' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction
set foldtext=MyFoldText()
" }}}

" Plugins Configuration {{{
" NERDTree
let NERDTreeIgnore=['\.rbc$', '\~$']
let NERDTreeQuitOnOpen=1

" Tagbar
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1

" Command-T configuration
let g:CommandTMaxHeight=20

" Syntastic
let g:syntastic_java_javac_args="-classpath /usr/local/Cellar/hadoop/1.1.1/libexec/hadoop-core-1.1.1.jar"

" CTags
map <Leader>rt :!/usr/local/bin/ctags --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>

func! RainbowLoad()
  RainbowParenthesesLoadRound
  RainbowParenthesesLoadSquare
  RainbowParenthesesLoadBraces
endfunc
au VimEnter * :RainbowParenthesesToggle
au Syntax * cal RainbowLoad()
au FileType * cal RainbowLoad()

au BufNewFile,BufRead *.{rabl,podspec} set filetype=ruby

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
" }}}

" Editor Behaviour {{{
set autoread                  " Remember last location in file
set timeoutlen=600            " timeout for leader maps

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set nolist
  set wrapmargin=0
  set textwidth=80
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Hammer<CR>
endfunction

" make uses real tabs
au FileType make set noexpandtab

function! SoftTab2()
  set expandtab
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
endfunction
map <leader>st2 <ESC>:call SoftTab2()<CR>

function! HardTab2()
  set noexpandtab
  set tabstop=2
  set shiftwidth=2
endfunction
map <leader>ht2 <ESC>:call HardTab2()<CR>

function! SoftTab4()
  set expandtab
  set tabstop=4
  set softtabstop=4
  set shiftwidth=4
endfunction
map <leader>st4 <ESC>:call SoftTab4()<CR>

function! HardTab4()
  set noexpandtab
  set tabstop=4
  set shiftwidth=4
endfunction
map <leader>ht4 <ESC>:call HardTab4()<CR>

" easy switching of themes
fun! BrightTheme()
  colorscheme Tomorrow
  set background=light
endfunction

fun! DarkTheme()
  colorscheme Tomorrow-Night
  set background=dark
endfunction

call DarkTheme()
map <leader>bt :call BrightTheme()<CR>
map <leader>dt :call DarkTheme()<CR>

" Project Tree
autocmd FocusGained * call s:UpdateNERDTree()
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

" NERDTree utility function
function s:UpdateNERDTree(...)
  let stay = 0

  if(exists("a:1"))
    let stay = a:1
  end

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      if !stay
        wincmd p
      end
    endif
  endif
endfunction

autocmd FileType ruby
      \ if expand('%') =~# '_test\.rb$' |
      \   compiler rubyunit | setl makeprg=testrb\ \"%:p\" |
      \ elseif expand('%') =~# '_spec\.rb$' |
      \   compiler rspec | setl makeprg=rspec\ \"%:p\" |
      \ else |
      \   compiler ruby | setl makeprg=ruby\ -wc\ \"%:p\" |
      \ endif

if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif
" }}}
