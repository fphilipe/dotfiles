if has("gui_macvim")
  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " Remove toolbar, left scrollbar and right scrollbar
  set guioptions-=T
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r
  set guioptions-=R

  set guifont=Source\ Code\ Pro\ for\ Powerline:h15
  set linespace=2
  set transparency=0
endif
