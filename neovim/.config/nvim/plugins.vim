let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Theme
" Plug 'gruvbox-community/gruvbox'
" Plug 'chriskempson/base16-vim'
Plug 'sainnhe/everforest'

" Lightline
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

" Movement
Plug 'justinmk/vim-sneak'               " Vim-Sneak

" Git
Plug 'mhinz/vim-signify'                " Git Gutter
Plug 'tpope/vim-fugitive'               " Vim-Fugitive
Plug 'tpope/vim-rhubarb'                " Vim-Rhubarb
Plug 'shumphrey/fugitive-gitlab.vim'    " Vim-Rhubarb for Gitlab

" Language Completion (LSP)
" switch to native LSP someday...
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " coc

" Languages specific
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }  " Go
" Plug 'jez/vim-better-sml'                           " SML
Plug 'cespare/vim-toml'                             " TOML
Plug 'pangloss/vim-javascript'                      " JavaScript support
" Plug 'leafgarland/typescript-vim'                   " TypeScript syntax
Plug 'preservim/tagbar'                             " tagbar
" Plug 'dag/vim-fish'                               " Fish
" (more) => see coc.vim                             " Coc Extensions

" Startify (the fancy startup page for vim)
Plug 'mhinz/vim-startify'

" Utils
Plug 'airblade/vim-rooter'              " stop vim from changing directory
" Plug 'dstein64/vim-startuptime'       " see whats slowing down the startup
Plug 'tpope/vim-commentary'             " commenting
Plug 'tpope/vim-surround'               " surround with brackets (like VSCode)
Plug 'andymass/vim-matchup'             " Matching brackets
Plug 'jiangmiao/auto-pairs'             " Auto pairs for '(' '[' '{'
Plug 'michaeljsmith/vim-indent-object'  " additional indent objects
Plug 'tpope/vim-obsession'              " Saving and restoring sessions
" Plug 'dbeniamine/todo.txt-vim'        " todo.txt => not using todo.txt for now
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}     " treesitter
Plug 'nvim-treesitter/nvim-treesitter-context'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }   " Fuzzy Finder => switched to Telescope
" Plug 'junegunn/fzf.vim'

" Copilot
Plug 'github/copilot.vim'           " copilot plugin

" telescope
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'fannheyward/telescope-coc.nvim'

" Coq
Plug 'whonore/Coqtail'

call plug#end()
