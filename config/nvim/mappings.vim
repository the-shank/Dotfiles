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

" X clipboard integration
" <Space>c will copy entire buffer into clipboard
" <Space>p will paste clipboard into buffer
noremap <leader>c :w !xsel -ib<cr><cr>
noremap <leader>p :read !xsel --clipboard --output<cr>

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Leader + tab to toggle between buffers
nnoremap <leader><tab> <c-^><CR>

" Use :Rg as a global search
noremap <leader>g :Rg<CR>

" vim-commentary
nnoremap <space>/ :Commentary<CR>
vnoremap <space>/ :Commentary<CR>

" <leader><leader> toggles between buffers
" nnoremap <leader><leader> <c-^>

" Ctrl-P for quick searching files
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

" Ctrl+h to stop searching
vnoremap <leader>h :nohlsearch<cr>
nnoremap <leader>h :nohlsearch<cr>
