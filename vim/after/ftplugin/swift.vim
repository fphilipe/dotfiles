setlocal shiftwidth=4
" swiftformat always includes an extra new line at the end. Remove it with sed.
setlocal formatprg=swiftformat\ --fragment\ true\ \|\ sed\ '$d'
