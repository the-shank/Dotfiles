" set leader key
let g:mapleader = "\<Space>"

filetype plugin indent on

set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler              			        " Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=4                           " Insert 2 spaces for a tab
set shiftwidth=4                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set laststatus=2                        " Always display the status line
set number                              " Line numbers
set relativenumber			            " Relative Line numbers
set cursorline                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " Always show tabs
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=250                      " By default timeoutlen is 1000 ms
set formatoptions-=c formatoptions-=r formatoptions-=o                  " Stop newline continution of comments
set clipboard=unnamedplus               " Copy paste between vim and everything else
set autochdir                           " Your working directory will always be the same as your working directory
set colorcolumn=80,100                  " a ruler at 80th & 100th char column
syntax enable                           " Enables syntax highlighing
set printfont=Monospace:h9              " Set the printfont (used with :hardcopy)
set printoptions=left:15pt,right:15pt,top:15pt,bottom:15pt      " printoptions
set scrollback=100000                   " integrated terminal scrollback
set scrolloff=3                         " start scrolling 3 lines before edge of the viewport (@ greg hurrell)
set noswapfile                          " disable swap files
set lazyredraw                          " disable redrawing when changing text

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" termguicolors
if has('termguicolors')
    set termguicolors
endif

" gruvbox theme >>
" let g:gruvbox_contrast_dark = 'hard'
" colorscheme gruvbox
" let base16colorspace=256
" colorscheme base16-gruvbox-dark-hard
" Brighter comments
" call Base16hi("Comment", g:base16_gui09, "", g:base16_cterm09, "", "", "")

" everforest theme >>
let g:everforest_background = 'hard'
colorscheme everforest

" trim trailing whitespace on save
autocmd FileType c,cpp,java,go,php,python,vim,yaml,rust autocmd BufWritePre <buffer> %s/\s\+$//e

" commentstrings
autocmd FileType c,cpp,cs,java  setlocal commentstring=//\ %s
autocmd FileType fish           setlocal commentstring=#\ %s

" folding based on treesitter
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable

" close fzf windows on <esc>
" https://github.com/junegunn/fzf/issues/1393#issuecomment-426576577
autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>

" always enter terminal in insert mode
" https://vi.stackexchange.com/a/3765/35373
autocmd BufWinEnter,WinEnter term://* startinsert
