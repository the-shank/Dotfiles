call plug#begin()

" Utils
Plug 'airblade/vim-rooter'

" Theme
Plug 'joshdick/onedark.vim'

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

" Vim-Surround
Plug 'tpope/vim-surround'

" Git Gutter
Plug 'mhinz/vim-signify'

" Programming Languages
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Coc Extensions
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'weirongxu/coc-explorer', {'do': 'yarn install --frozen-lockfile'}
Plug 'clangd/coc-clangd', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-go', {'do': 'yarn install --frozen-lockfile'}

call plug#end()
