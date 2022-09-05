if &t_Co > 16
  hi def CoqtailChecked ctermbg=17 guibg=DimGray
  hi def CoqtailSent    ctermbg=60 guibg=DimGray
else
  hi def CoqtailChecked ctermbg=4 guibg=LightGreen
  hi def CoqtailSent    ctermbg=7 guibg=LimeGreen
endif
hi def link CoqtailError Error
