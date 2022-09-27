" https://dockyard.com/blog/2018/06/01/simple-vim-session-management-part-1
" https://dockyard.com/blog/2019/06/25/simple-vim-session-management-part-2
let g:sessions_dir = '~/.vim-sessions'
exec 'nnoremap <Leader>ss :Obsession ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sr :so ' . g:sessions_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'
