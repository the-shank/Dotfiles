call plug#begin()

" Utils
Plug 'airblade/vim-rooter'

" Theme
" Plug 'joshdick/onedark.vim'
Plug 'gruvbox-community/gruvbox'
" Plug 'NLKNguyen/papercolor-theme'

" commenting
Plug 'tpope/vim-commentary'

" Fuzzy Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Auto pairs for '(' '[' '{'
Plug 'jiangmiao/auto-pairs'

" Quickscope
Plug 'unblevable/quick-scope'

" Floaterm
Plug 'voldikss/vim-floaterm'

" Matching brackets
Plug 'andymass/vim-matchup'

" Lightline
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

" Vim-Surround
Plug 'tpope/vim-surround'

" Git Gutter
Plug 'mhinz/vim-signify'

" Vim-Fugitive
Plug 'tpope/vim-fugitive'

" Vim-Which-Key
Plug 'liuchengxu/vim-which-key'

" Programming Languages
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }  " Go
Plug 'jez/vim-better-sml'                           " SML

" Language Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Coc Extensions
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'weirongxu/coc-explorer', {'do': 'yarn install --frozen-lockfile'}
Plug 'clangd/coc-clangd', {'do': 'yarn install --frozen-lockfile'}
" Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-go', {'do': 'yarn install --frozen-lockfile'}

" TOML
Plug 'cespare/vim-toml'

" Fish
Plug 'dag/vim-fish'

" Startup time
Plug 'dstein64/vim-startuptime'

call plug#end()
