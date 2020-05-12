" ****************************************************************************
" Plugins
" ****************************************************************************
call plug#begin()

" Theme
Plug 'joshdick/onedark.vim'
Plug 'nanotech/jellybeans.vim'

" Utils
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

" Language Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fuzzy Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Auto pairs for '(' '[' '{' 
Plug 'jiangmiao/auto-pairs' 		

call plug#end()
" ****************************************************************************
" Plugins (End)
" ****************************************************************************

" nerdtree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" automaticaly close nvim if NERDTree is only thing left open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" toggle nerdtree
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" fzf
nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" coc-extensions
let g:coc_global_extensions = [
	\'coc-go',
	\'coc-python',
	\'coc-json',
	\'coc-rust-analyzer'
	\]
