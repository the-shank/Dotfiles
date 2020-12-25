call plug#begin()

" Theme
Plug 'gruvbox-community/gruvbox'

" Lightline
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

" commenting
Plug 'tpope/vim-commentary'

" Movement
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }   " Fuzzy Finder
Plug 'junegunn/fzf.vim'
Plug 'unblevable/quick-scope'   " Quickscope

" Auto pairs for '(' '[' '{'
Plug 'jiangmiao/auto-pairs'

" Matching brackets
Plug 'andymass/vim-matchup'

" Vim-Surround
Plug 'tpope/vim-surround'

" Git
Plug 'mhinz/vim-signify'    " Git Gutter
Plug 'tpope/vim-fugitive'   " Vim-Fugitive

" Vim-Which-Key
Plug 'liuchengxu/vim-which-key'

" Language Completion (LSP)
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " coc

" Programming Languages
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }  " Go
Plug 'jez/vim-better-sml'                           " SML
Plug 'cespare/vim-toml'                             " TOML
" Plug 'dag/vim-fish'                               " Fish
" (more) => see coc.vim                             " Coc Extensions

" Startify (the fancy startup page for vim)
Plug 'mhinz/vim-startify'

" Utils
Plug 'airblade/vim-rooter'          " stop vim from changing directory
" Plug 'voldikss/vim-floaterm'      " floating terminal
" Plug 'dstein64/vim-startuptime'   " see whats slowing down the startup

call plug#end()
