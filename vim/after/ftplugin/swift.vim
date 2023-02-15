setlocal shiftwidth=2
setlocal textwidth=80
setlocal comments=s1:/*,mb:*,ex:*/,:///\ -\ ,:///,://\ -\ ,://
" swiftformat always includes an extra new line at the end. Remove it with sed.
setlocal formatprg=swiftformat\ --fragment\ true\ --config\ .swiftformat\ --swiftversion\ \$(<\ .swift-version)\ 2&>\ /dev/null
