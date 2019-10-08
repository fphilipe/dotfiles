setlocal shiftwidth=4
setlocal textwidth=80
setlocal comments=s1:/*,mb:*,ex:*/,:///\ -\ ,:///,://\ -\ ,://
" swiftformat always includes an extra new line at the end. Remove it with sed.
setlocal formatprg=swiftformat\ --fragment\ true\ \|\ sed\ '$d'
