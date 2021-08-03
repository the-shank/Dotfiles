" install vim-plug if required
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Theme
Plug 'gruvbox-community/gruvbox'
Plug 'chriskempson/base16-vim'

" Lightline
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

" Movement
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }   " Fuzzy Finder
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'               " Vim-Sneak

" Git
Plug 'mhinz/vim-signify'                " Git Gutter
Plug 'tpope/vim-fugitive'               " Vim-Fugitive
Plug 'tpope/vim-rhubarb'                " Vim-Rhubarb
Plug 'shumphrey/fugitive-gitlab.vim'    " Vim-Rhubarb for Gitlab

" Language Completion (LSP)
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " coc

" Programming Languages
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
Plug 'airblade/vim-rooter'        " stop vim from changing directory
" Plug 'dstein64/vim-startuptime'   " see whats slowing down the startup
Plug 'tpope/vim-commentary'         " commenting
Plug 'tpope/vim-surround'           " surround with brackets (like VSCode)
Plug 'andymass/vim-matchup'         " Matching brackets
Plug 'jiangmiao/auto-pairs'         " Auto pairs for '(' '[' '{'
Plug 'liuchengxu/vim-which-key'     " Vim-Which-Key
Plug 'michaeljsmith/vim-indent-object'  " additional indent objects
Plug 'tpope/vim-obsession'          " Saving and restoring sessions
Plug 'dbeniamine/todo.txt-vim'      " todo.txt

call plug#end()
