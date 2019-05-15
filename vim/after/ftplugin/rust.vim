setlocal formatprg=rustfmt
setlocal makeprg=cargo\ build
nmap <buffer> <localleader>m :wa \| :Make<CR>
nmap <buffer> <localleader>r :wa \| :Dispatch cargo run<CR>
