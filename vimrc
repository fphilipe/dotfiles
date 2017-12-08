" .vimrc
" Author: Philipe Fatio <me@phili.pe>

" Preamble                                                                   {{{

" Use vim settings, rather then vi settings (much better!)
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off
set encoding=utf-8

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" }}}
" Plugins                                                                    {{{

Plugin '5long/pytest-vim-compiler'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized' "{{{
  let g:solarized_contrast='high'
  let g:solarized_visibility='high'
"}}}
Plugin 'AndrewRadev/splitjoin.vim' "{{{
  let g:splitjoin_ruby_hanging_args=0
  let g:splitjoin_ruby_curly_braces=0
"}}}
Plugin 'bruno-/vim-vertical-move'
Plugin 'chriskempson/base16-vim'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'cohama/lexima.vim'
Plugin 'croaky/vim-colors-github'
Plugin 'elixir-lang/vim-elixir'
Plugin 'fweep/vim-zsh-path-completion'
Plugin 'gmarik/vundle'
Plugin 'godlygeek/tabular' "{{{
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
"}}}
Plugin 'janko-m/vim-test' "{{{
  let test#strategy = "dispatch"
  nmap <silent> <leader>tn :silent! noautocmd wa \| TestNearest<CR>
  nmap <silent> <leader>tf :silent! noautocmd wa \| TestFile<CR>
  nmap <silent> <leader>ta :silent! noautocmd wa \| TestSuite<CR>
  nmap <silent> <leader>tl :silent! noautocmd wa \| TestLast<CR>
  nmap <silent> <leader>tg :silent! noautocmd wa \| TestVisit<CR>
"}}}
Plugin 'jrestrepo/matlab'
Plugin 'JuliaLang/julia-vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim' "{{{
  nmap <C-P><C-F> :<C-U>Files<CR>
  nmap <C-P><C-B> :<C-U>Buffers<CR>
  nmap <C-P><C-T> :<C-U>Tags<CR>
  let $FZF_DEFAULT_COMMAND = 'ag -g ""'
  let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit' }
  let g:fzf_history_dir = '~/.local/share/fzf-history'
"}}}
Plugin 'junegunn/goyo.vim'
Plugin 'kana/vim-textobj-user'
Plugin 'Keithbsmiley/swift.vim'
Plugin 'Konfekt/FastFold'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'majutsushi/tagbar' "{{{
  let g:tagbar_autoclose = 1
  let g:tagbar_autofocus = 1
  let tlist_objc_settings = 'ObjectiveC;P:protocols;i:interfaces;types(...)'
  let g:tagbar_type_objc = {
    \ 'ctagstype' : 'ObjectiveC',
    \ 'kinds' : [
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
  map <right> <ESC>:TagbarToggle<CR>
"}}}
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'matchit.zip'
Plugin 'mileszs/ack.vim' "{{{
  let g:ackprg = 'ag --vimgrep --smart-case'
"}}}
Plugin 'mkitt/tabline.vim'
Plugin 'mxw/vim-jsx'
Plugin 'nelstrom/vim-markdown-folding'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'ngmy/vim-rubocop'
Plugin 'pangloss/vim-javascript'
Plugin 'plasticboy/vim-markdown' "{{{
  let g:vim_markdown_math=1
  let g:vim_markdown_frontmatter=1
"}}}
Plugin 'rainbow_parentheses.vim'
Plugin 'ruby-matchit'
Plugin 'rust-lang/rust.vim'
Plugin 'ryan-cf/netrw' "{{{
  let g:netrw_liststyle=3
  let g:netrw_browsex_viewer="open"
  let g:netrw_list_hide='^\(\.bundle\/\|\.sass-cache\/\|\.DS_Store\|\.git\/\|Build\/\|.*\.xcodeproj\/\|.*xcworkspace\/\|\.yardoc\)$'
"}}}
Plugin 'scrooloose/nerdtree' "{{{
  let NERDTreeIgnore=[
  \ '\.rbc$',
  \ '\~$',
  \ 'tags[[file]]',
  \ '.\.pyc[[file]]',
  \ 'tmp[[dir]]',
  \ 'build[[dir]]',
  \ 'bin[[dir]]',
  \ 'coverage[[dir]]',
  \ '__pycache__[[dir]]'
  \]
  let NERDTreeQuitOnOpen=1
  map <left> <ESC>:NERDTreeToggle<CR>
  map <S-left> <ESC>:NERDTreeFind<CR>
"}}}
Plugin 'scrooloose/syntastic'
Plugin 'SirVer/ultisnips' "{{{
  let g:UltiSnipsListSnippets="<S-Tab>"
  let g:UltiSnipsExpandTrigger="<Tab>"
  let g:UltiSnipsJumpForwardTrigger="<C-J>"
  let g:UltiSnipsJumpBackwardTrigger="<C-K>"
  let g:UltiSnipsSnippetsDir="~/.vim/snips"
  let g:UltiSnipsSnippetDirectories=["snips"]
  let g:UltiSnipsEditSplit='context'
  let g:UltiSnipsEnableSnipMate=0
  set rtp+=~/.vim
  au BufNewFile,BufRead *_spec.rb UltiSnipsAddFiletypes rspec
  map <leader>es :UltiSnipsEdit<CR>:lcd %:p:h<CR>
"}}}
Plugin 'sjl/gundo.vim' "{{{
  let g:gundo_right = 1
  map <S-right> <ESC>:GundoToggle<CR>
"}}}
Plugin 'sjl/vitality.vim'
Plugin 'slim-template/vim-slim'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-dispatch' "{{{
  let g:dispatch_tmux_height=15
  " Tmux 2.3 related problem that prevents the output from being parsed
  " properly. https://github.com/tpope/vim-dispatch/issues/192
  set shellpipe+=\ 
  map <silent> <leader>d :silent! noautocmd wa \| Dispatch<CR>
"}}}
Plugin 'tpope/vim-fugitive' "{{{
  map <leader>gs :Gstatus<CR>
  map <leader>gS :Gtabedit :<CR>
  map <leader>gd :Gdiff<CR>
  map <leader>gc :Gcommit<CR>
  map <leader>gw :Gwrite<CR>
  map <leader>gr :Gread<CR>
  map <leader>gb :Gblame<CR>
  " When diffing two files, save and close the index file, go to the git status
  " split below and jump to the next file:
  map <leader>gn :x<CR><C-w>j<C-n>D
"}}}
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-obsession.git'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-coffee-script'
Plugin 'vim-ruby/vim-ruby' "{{{
let ruby_spellcheck_strings = 1
"}}}
Plugin 'vim-utils/vim-husk'
Plugin 'wlangstroth/vim-haskell'

call vundle#end()

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

" Escape sequences for italic.
set t_ZH=[3m
set t_ZR=[23m

" http://snk.tuxfamily.org/log/vim-256color-bce.html
" Disable Background Color Erase (BCE) so that color schemes
" work properly when Vim is used inside tmux and GNU screen.
if &term =~ '256color'
  set t_ut=
endif

" Make Vim recognize XTerm escape sequences for Page and Arrow
" keys combined with modifiers such as Shift, Control, and Alt.
" See http://www.reddit.com/r/vim/comments/1a29vk/_/c8tze8p
if &term =~ '^tmux'
  " Page keys http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/FAQ
  execute "set t_kP=\e[5;*~"
  execute "set t_kN=\e[6;*~"

  " Arrow keys http://unix.stackexchange.com/a/34723
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

" suppress all bells
set novisualbell
set noerrorbells
set vb

set mouse=a                     " enable using the mouse if terminal emulator
                                "    supports it (xterm does)
if !has('nvim')
  set ttymouse=xterm2           " make split resizing work inside tmux
endif

set fileformats="unix,dos,mac"

set textwidth=80
set formatoptions=1cnqroj

set synmaxcol=200               " only do syntax highlighting within first 200 columns
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

" Save whenever switching windows or leaving vim.
au FocusLost * :silent! wa
" Trigger autoread when coming back to vim.
au FocusGained * :silent! !

" }}}
" Key Mappings                                                               {{{

" The current directory for the active file
cnoremap %% <C-R>=expand('%:h').'/'<CR>
" Remap partial history search
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" make j and k always move to next visual line (useful for wrapped lines).
nnoremap j gj
nnoremap k gk

" clean whitespace in file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

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
nmap <leader>Y "*y$
nmap <leader>p "*p
nmap <leader>P "*P
vmap <leader>y "*y
vmap <leader>p "*p

" Make Arrow Keys Useful Again
map <down> <ESC>:ccl<CR>
map <up> <ESC>:cope<CR>

" Unimpaired configuration
" Bubble single lines
nmap <M-Up> [e
nmap <M-Down> ]e
" Bubble multiple lines
vmap <M-Up> [egv
vmap <M-Down> ]egv

" highlight lines longer than 80 chars
nnoremap <leader>ll /\%>80v.\+<CR>

" Quickly open certain files for editing
map <leader>ev :tabe ~/dotfiles/vimrc<CR>:lcd %:p:h<CR>

" CTags
map <leader>ct :!ctags --extra=+f -R<CR><CR>

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
" Editor Behavior                                                            {{{

set autoread                  " Remember last location in file
set timeoutlen=600            " timeout for leader maps

set diffopt=vertical,filler

if executable('ag')
  set grepprg=ag\ --vimgrep
endif

if filereadable(expand('~/.vimrc_background'))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" }}}
" File Type Configurations                                                   {{{

au FileType javascript,css,less,scss,objc,c,vim setlocal foldmethod=marker
au FileType javascript,css,less,scss,objc,c setlocal foldmarker={,}
au FileType coffee,slim,yaml,python setlocal foldmethod=expr

au FileType scss setlocal iskeyword+=@-@,$,-,%,#,.
au FileType css setlocal iskeyword+=-,#,.
au FileType coffee setlocal iskeyword+=$

au FileType make,snippets setlocal noexpandtab
au FileType objc,sql setlocal shiftwidth=4

" Delete certain buffers in order to not cluttering up the buffer list:
au BufReadPost fugitive://* set bufhidden=delete
au BufReadPost ~/.gem/* set bufhidden=delete
au BufReadPost ~/dotfiles/* set bufhidden=delete

au BufNewFile,BufRead {Gem,Pod,Rake}file,*.{rabl,podspec} set filetype=ruby

" Don't autowrap lines when writing a pull request as line breaks are preserved
" on GitHub; softwrap instead:
au VimEnter PULLREQ_EDITMSG setlocal formatoptions-=t wrap

" }}}
" Searches                                                                   {{{
let SqlCapitalize = '\<\(create\|insert\|select\|update\|alter\|set\|from\|where\|and\|or\|on\|join\|not\|null\|is\|using\|case\|when\|else\|if\|elsif\|end\|as\|order\|by\|asc\|desc\|limit\|with\|over\|partition\|group\|like\|left\|right\|outer\|inner\|full\|union\|all\|distinct\|coalesce\|natural\|window\|unique\|index\|drop\|table\|column\|begin\|commit\|abort\|rollback\|rename\|add\|remove\|to\|exists\|primary key\|extension\|explain\|analyze\)\>\C'
" }}}
" Highlighting                                                                   {{{
highlight Comment cterm=italic
" }}}
