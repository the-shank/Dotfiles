" ; as :
nnoremap ; :

" Jump to start and end of line using the home row keys
map H ^
map L $

" use alt+hjkl to move between split/vsplit panels
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

" indent / outdent 
vnoremap < <gv
vnoremap > >gv

" Use ctrl + hjkl to resize windows
nnoremap <C-k>    :resize -2<CR>
nnoremap <C-j>    :resize +2<CR>
nnoremap <C-h>    :vertical resize -2<CR>
nnoremap <C-l>    :vertical resize +2<CR>

nnoremap <leader>d dd

" X clipboard integration
" <Space>c will copy entire buffer into clipboard
noremap <leader>c :w !xsel -ib<cr><cr>

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
