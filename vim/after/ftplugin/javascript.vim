let g:syntastic_javascript_checkers = ['eslint']

setlocal formatprg=prettier\
      \ --stdin\
      \ --parser\ babel\
      \ --print-width\ 80\
      \ --single-quote\
      \ --no-semi\
      \ --trailing-comma\ es5
