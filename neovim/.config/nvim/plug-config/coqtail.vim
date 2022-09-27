if &t_Co > 16
  hi def CoqtailChecked ctermbg=17 guibg=DarkGreen
  hi def CoqtailSent    ctermbg=60 guibg=DarkGrey
else
  hi def CoqtailChecked ctermbg=4 guibg=LightGreen
  hi def CoqtailSent    ctermbg=7 guibg=LimeGreen
endif
hi def link CoqtailError Error
