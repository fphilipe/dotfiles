setlocal formatoptions-=a
setlocal textwidth=72
setlocal colorcolumn=51

" Collapse all folds but leave the first one listing files to be committed open:
setlocal foldenable foldlevel=0
silent! 1,/^#$/foldopen
