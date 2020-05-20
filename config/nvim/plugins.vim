call plug#begin()

" Utils
Plug 'airblade/vim-rooter'

" Theme
Plug 'joshdick/onedark.vim'
Plug 'nanotech/jellybeans.vim'

" commenting
Plug 'tpope/vim-commentary'

" Language Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fuzzy Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Auto pairs for '(' '[' '{' 
Plug 'jiangmiao/auto-pairs' 		

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Ranger
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}

" Git Gutter
Plug 'mhinz/vim-signify'

call plug#end()
