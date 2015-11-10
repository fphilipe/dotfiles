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

Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'bling/vim-airline'
Plugin 'bruno-/vim-vertical-move'
Plugin 'chriskempson/base16-vim'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'croaky/vim-colors-github'
Plugin 'elixir-lang/vim-elixir'
Plugin 'gmarik/vundle'
Plugin 'godlygeek/tabular'
Plugin 'janko-m/vim-test'
Plugin 'jgdavey/vim-turbux'
Plugin 'jiangmiao/auto-pairs'
Plugin 'jrestrepo/matlab'
Plugin 'JuliaLang/julia-vim'
Plugin 'kana/vim-textobj-user'
Plugin 'Keithbsmiley/swift.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'LnL7/vim-tslime'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'majutsushi/tagbar'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'matchit.zip'
Plugin 'mkitt/tabline.vim'
Plugin 'nelstrom/vim-markdown-folding'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'ngmy/vim-rubocop'
Plugin 'rainbow_parentheses.vim'
Plugin 'rking/ag.vim'
Plugin 'ruby-matchit'
Plugin 'rust-lang/rust.vim'
Plugin 'ryan-cf/netrw'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'sjl/gundo.vim'
Plugin 'sjl/vitality.vim'
Plugin 'slim-template/vim-slim'
Plugin 'svermeulen/vim-quickfixdo'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'Twinside/vim-haskellConceal'
Plugin 'vim-coffee-script'
Plugin 'vim-ruby/vim-ruby'
Plugin 'wlangstroth/vim-haskell'
Plugin 'https://bitbucket.org/larsyencken/vim-drake-syntax.git'

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
set number                      " use absolute line numbers
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
set sidescrolloff=5             " keep x columns off the edges of the screen when scrolling horizontally
set incsearch                   " show search matches as you type
set gdefault                    " search/replace "globally" (on a line) by default
set listchars=tab:▸\ ,trail:·,extends:…,precedes:…,nbsp:·
set list                        " show above special chars
let &showbreak='↪ '
set display+=lastline
set pastetoggle=<F2>            " when in insert mode, press <F2> to go to
                                "   paste mode, where you can paste mass data
                                "   that won't be autoindented
set t_Co=256                    " Explicitly tell that the terminal has 256 colors

" http://snk.tuxfamily.org/log/vim-256color-bce.html
" Disable Background Color Erase (BCE) so that color schemes
" work properly when Vim is used inside tmux and GNU screen.
if &term =~ '256color'
  set t_ut=
endif

" suppress all bells
set novisualbell
set noerrorbells
set vb

set mouse=a                     " enable using the mouse if terminal emulator
                                "    supports it (xterm does)
set ttymouse=xterm2             " make split resizing work inside tmux

set fileformats="unix,dos,mac"

set textwidth=80
set formatoptions=1cnqroj

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

" Save whenever switching windows or leaving vim. This is useful when running
" the tests inside vim without having to save all files first.
au FocusLost,WinLeave * :silent! wa

" Trigger autoread when changing buffers or coming back to vim.
au FocusGained,BufEnter * :silent! !

" When switching panes in tmux, an escape sequence is printed. Redrawing gets
" rid of it. See https://gist.github.com/mislav/5189704#comment-951447
au FocusLost * :redraw!

" Clear CtrlP cache when coming back to vim and after writing a file.
au FocusGained,BufWritePost * :CtrlPClearCache

" }}}
" Key Mappings                                                               {{{

" The current directory for the active file
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" make j and k always move to next visual line (useful for wrapped lines).
nnoremap j gj
nnoremap k gk

" clean whitespace in file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" navigate around split windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" open alternate file in split
nnoremap <leader>av :vsp\|A<CR>
nnoremap <leader>as :sp\|A<CR>

" Keep search matches in the middle of the window and open the fold.
nnoremap * *zvzz
nnoremap # #zvzz
nnoremap n nzvzz
nnoremap N Nzvzz

" Same behavior as C
nnoremap D d$
nnoremap Y y$

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
map <down> <ESC>:ccl<CR>
map <up> <ESC>:cope<CR>
map <left> <ESC>:NERDTreeToggle<CR>
map <S-left> <ESC>:NERDTreeFind<CR>
map <right> <ESC>:TagbarToggle<CR>
map <S-right> <ESC>:GundoToggle<CR>

" Unimpaired configuration
" Bubble single lines
nmap <M-Up> [e
nmap <M-Down> ]e
" Bubble multiple lines
vmap <M-Up> [egv
vmap <M-Down> ]egv

" go to insert with an empty line above and below
nmap <leader>o o<CR><CR><Up>
" go to insert with an empty line above and below
nmap <leader>O O<CR><CR><Up>

" highlight lines longer than 80 chars
nnoremap <leader>ll /\%>80v.\+<CR>

" Adjust viewports to the same size
map <Leader>= <C-w>=

" open ControlP in tag mode
map <C-t> :CtrlPTag<CR>

" Quickly open certain files for editing
map <leader>ev :tabe ~/dotfiles/vimrc<CR>:lcd %:p:h<CR>
map <leader>em :tabe ~/.vimmnemonics<CR>
map <leader>es :tabe<CR>:UltiSnipsEdit<CR>:lcd %:p:h<CR>

" Quickly call fugitive stuff
map <leader>gs :Gstatus<CR>
map <leader>gS :Gtabedit :<CR>
map <leader>gd :Gdiff<CR>
map <leader>gc :Gcommit<CR>
map <leader>gw :Gwrite<CR>
map <leader>gr :Gread<CR>
map <leader>gb :Gblame<CR>
" When diffing two files, save the one on the left, close it, go to the git
" status split below and jump to the next file:
map <leader>gn <C-w>h:x<CR><C-w>j<C-n>

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

" Fold for languages that use indentation. The indent fold method uses the first
" line of an indentation level as the fold. This will use the previous line as
" the fold.
" http://learnvimscriptthehardway.stevelosh.com/chapters/49.html
function! GetIndentationFold(lnum)
    if getline(a:lnum) =~? '\v^\s*$'
        return '-1'
    endif

    let this_indent = IndentLevel(a:lnum)
    let next_indent = IndentLevel(NextNonBlankLine(a:lnum))

    if next_indent == this_indent
        return this_indent
    elseif next_indent < this_indent
        return this_indent
    elseif next_indent > this_indent
        return '>' . next_indent
    endif
endfunction

function! IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction

function! NextNonBlankLine(lnum)
    let numlines = line('$')
    let current = a:lnum + 1

    while current <= numlines
        if getline(current) =~? '\v\S'
            return current
        endif

        let current += 1
    endwhile

    return -2
endfunction

set foldexpr=GetIndentationFold(v:lnum)

" }}}
" Plugins Configuration                                                      {{{

" Netrw
let g:netrw_liststyle=3
let g:netrw_browsex_viewer="open"
let g:netrw_list_hide='^\(\.bundle\/\|\.sass-cache\/\|\.DS_Store\|\.git\/\|Build\/\|.*\.xcodeproj\/\|.*xcworkspace\/\|\.yardoc\)$'

" NERDTree
let NERDTreeIgnore=[
\ '\.rbc$',
\ '\~$',
\ 'tags[[file]]',
\ '.\.pyc[[file]]',
\ 'doc[[dir]]',
\ 'tmp[[dir]]',
\ 'build[[dir]]',
\ 'doc[[dir]]',
\ 'bin[[dir]]',
\ 'coverage[[dir]]',
\ '__pycache__[[dir]]'
\]
let NERDTreeQuitOnOpen=1

" Tagbar
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1

" Syntastic
let g:syntastic_java_javac_args="-classpath /usr/local/Cellar/hadoop/1.1.1/libexec/hadoop-core-1.1.1.jar"
let g:syntastic_python_checkers = ['flake8']

" CTags
map <leader>ct :!/usr/local/bin/ctags --extra=+f -R *<CR><CR>

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
let g:tagbar_type_coffee = {
  \ 'ctagsbin' : 'coffeetags',
  \ 'ctagsargs' : '',
  \ 'kinds' : [
    \ 'f:functions',
    \ 'o:object',
  \ ],
  \ 'sro' : ".",
  \ 'kind2scope' : {
    \ 'f' : 'object',
    \ 'o' : 'object',
  \ }
\ }

" airline
let g:airline_powerline_fonts=1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_left_alt_sep='-'
let g:airline_right_alt_sep='-'
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#hunks#enabled = 0
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }

" ControlP
let g:ctrlp_extensions = ['tag']
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn|sass-cache|bundle|tmp|yardoc)|build|tmp|bin|node_modules|docs?|vendor\/bundle)$',
  \ 'file': '\v(\.(exe|so|dll|DS_Store)|tags)$',
  \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
  \ }
let g:ctrlp_cmd = 'CtrlPCurWD'

let g:gundo_right = 1

let g:turbux_command_rspec = 'rspec -fp'
let g:no_turbux_mappings = 1
" Rspec line
map <leader>rl <Plug>SendFocusedTestToTmux
" Rspec file
map <leader>rf <Plug>SendTestToTmux
" Rspec file format doc
map <leader>rd :silent! w \| call SendToTmux("rspec -fd --order default -- ".expand("%")."\n")<CR>
" Rspec all
map <leader>ra :silent! w \| Dispatch rspec -fp -- spec<CR>
" Rspec all format doc
map <leader>rad :silent! w \| call SendToTmux("rspec -fd -- spec\n")<CR>
" Rspec all format doc
map <leader>rc :silent! w \| :RuboCop<CR>
" Dispatch
map <leader>d :Dispatch<space>
" Tx
map <leader>tx :Tx<space>
" Karma unit
map <leader>ku :silent! w \| Dispatch grunt karma:unit_once<CR>

" vim-test
let test#strategy = "dispatch"

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetsDir="~/.vim/snips"
let g:UltiSnipsSnippetDirectories=["snips"]
set rtp+=~/.vim

" Tabular
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs/l0r1<CR>
vmap <Leader>a: :Tabularize /:\zs/l0r1<CR>
nmap <Leader>a, :Tabularize /,\zs/l0r1<CR>
vmap <Leader>a, :Tabularize /,\zs/l0r1<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" Fugitive
set diffopt=vertical,filler

" NERDCommented
let g:NERDSpaceDelims=1

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
  colorscheme base16-ocean
else
  set bg=dark
  colorscheme base16-ocean
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
au FileType coffee,slim,yaml,python setlocal foldmethod=expr

au FileType scss setlocal iskeyword+=@-@,$,-,%,#,.
au FileType css setlocal iskeyword+=-,#,.
au FileType coffee setlocal iskeyword+=$

au FileType gitcommit setlocal formatoptions+=a
au FileType gitcommit setlocal textwidth=72
au FileType gitcommit setlocal colorcolumn=51

au FileType python setlocal textwidth=72
au FileType python setlocal colorcolumn=80

au FileType make,snippets setlocal noexpandtab
au FileType objc,sql setlocal shiftwidth=4

" Delete certain buffers in order to not cluttering up the buffer list:
au BufReadPost fugitive://* set bufhidden=delete
au BufReadPost ~/.gem/* set bufhidden=delete
au BufReadPost ~/dotfiles/* set bufhidden=delete

au BufNewFile,BufRead {Gem,Pod,Rake}file,*.{rabl,podspec} set filetype=ruby
au BufNewFile,BufRead *_spec.rb set filetype=rspec.ruby

" Don't autowrap lines when writing a pull request as line breaks are preserved:
au VimEnter PULLREQ_EDITMSG setlocal formatoptions-=t
" Since we no longer autowrap at least soft wrap:
au VimEnter PULLREQ_EDITMSG setlocal wrap

" }}}
" Searches                                                                   {{{
let SqlCapitalize = '\<\(select\|update\|set\|from\|where\|and\|or\|on\|join\|not\|null\|is\|using\|case\|when\|else\|if\|elsif\|end\|as\|order\|by\|asc\|desc\|limit\|with\|over\|partition\|group\|like\|left\|right\|outer\|inner\|full\|union\|all\|distinct\|coalesce\)\>\C'
" }}}
