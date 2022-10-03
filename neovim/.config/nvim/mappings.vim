" ; as :
" nnoremap ; :

" Jump to start and end of line using the home row keys
" map H ^
" map L $

" use alt+hjkl to move between split/vsplit panels
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

" indent / outdent
vnoremap < <gv
vnoremap > >gv

" Use ctrl + hjkl to resize windows
nnoremap <C-Up>    :resize +2<CR>
nnoremap <C-Down>    :resize -2<CR>
nnoremap <C-Left>    :vertical resize -2<CR>
nnoremap <C-Right>    :vertical resize +2<CR>

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>

" No backspace in insert mode --- force yourself to use normal mode for
" deletion
inoremap <BS> <nop>
inoremap <Del> <nop>

" Left and right can switch buffers
" nnoremap <left> :bp<CR>
" nnoremap <right> :bn<CR>

" H,L can switch buffers
nnoremap <S-h> :bp!<CR>
nnoremap <S-l> :bn!<CR>

" close buffer (miguel grinberg: https://gist.github.com/miguelgrinberg/527bb5a400791f89b3c4da4bd61222e4)
nnoremap <leader>x :bp<bar>bd#<CR>

" Leader + tab to toggle between buffers
noremap <leader><tab> <C-^><CR>

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" vim-commentary
nnoremap <leader>/ :Commentary<CR>
vnoremap <leader>/ :Commentary<CR>

" remove highlights
vnoremap <leader>h :nohlsearch<CR>
nnoremap <leader>h :nohlsearch<CR>

" Leader + g + o to git-open the current repository page
nnoremap <leader>go :!git-open<CR>

" Save and quit mapped to <leader>w and <leader>q
nnoremap <leader>w :w<CR>
vnoremap <leader>w :w<CR>
" nnoremap <leader>q :q<CR>
" vnoremap <leader>q :q<CR>

" Save and quit mapped to ;w and ;q
nnoremap ;q :q<CR>
vnoremap ;q :q<CR>
" nnoremap ;w :w<CR>
" vnoremap ;w :w<CR>

" tagbar (miguel grinberg: https://gist.github.com/miguelgrinberg/527bb5a400791f89b3c4da4bd61222e4)
map <leader>t :TagbarToggle<CR>

" vsplit
noremap <leader>v :vsplit<CR>

" exit the terminal mode
tnoremap <Esc> <C-\><C-n>

" send <Esc> in terminal mode
tnoremap <A-[> <Esc>

" command for enable/disable line-wrapping
command! -nargs=* Wrap set wrap! linebreak!

" goto file but in a vertical split
nnoremap gv :vertical wincmd f<CR>

" reload config
nnoremap <F4> :source ~/.config/nvim/init.vim<CR>

" relative path (src/foo.txt)
nnoremap <leader>yf :let @+=expand("%")<CR>

" absolute path (/something/src/foo.txt) (mnemonic -> <y>ank <p>ath)
nnoremap <leader>yp :let @+=expand("%:p").':'.line(".")<CR>

" filename (foo.txt)
nnoremap <leader>yt :let @+=expand("%:t")<CR>

" close the split
nnoremap <leader>sc :close<CR>

" close all buffers except the current one
" https://salferrarello.com/vim-close-all-buffers-except-the-current-one/
command! BufOnly execute '%bdelete|edit #|normal `"'

" move text up and down (chris@machine and vim.fandom.com)
" https://vim.fandom.com/wiki/Moving_lines_up_or_down#Mappings_to_move_lines
nnoremap <C-A-j> :m .+1<CR>==
nnoremap <C-A-k> :m .-2<CR>==
vnoremap <C-A-j> :m '>+1<CR>gv=gv
vnoremap <C-A-k> :m '<-2<CR>gv=gv

" dont overwrite clipboard when pasting (chris@machine)
vnoremap p "_dP
