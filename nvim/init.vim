let mapleader = ","

filetype on
filetype indent on
filetype plugin on

set encoding=UTF-8

syntax on
set nocompatible
set hlsearch
set number relativenumber
set laststatus=2
set vb
set ruler
set spelllang=en_us
set autoindent
set colorcolumn=90
set mouse=a
set clipboard=unnamed
set noscrollbind
set wildmenu
set autochdir


" inoremap " ""<left>
" inoremap ' ''<left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap < <><left>
" inoremap { {}<left>
" inoremap {<CR> {<CR>}<ESC>O
" inoremap {;<CR> {<CR>};<ESC>O

set tabstop=4
set shiftwidth=4

hi Search cterm=NONE ctermfg=black ctermbg=red

" No more Arrow Keys, deal with it
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" netrw

nnoremap - :Explore<CR>
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
autocmd FileType netrw setl bufhidden=delete

"-- netrw END

" plug 
call plug#begin()
    "> Must Have
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
    Plug 'vim-airline/vim-airline'" https://github.com/vim-airline/vim-airline
    Plug 'ctrlpvim/ctrlp.vim'      " https://github.com/ctrlpvim/ctrlp.vim
    Plug 'ryanoasis/vim-devicons'  " https://github.com/ryanoasis/vim-devicons + https://github.com/ryanoasis/nerd-fonts/
    Plug 'tpope/vim-commentary'    " https://github.com/tpope/vim-commentary
    Plug 'airblade/vim-gitgutter'  " https://github.com/airblade/vim-gitgutter
    Plug 'mkitt/tabline.vim'       " https://github.com/mkitt/tabline.vim
	" Plug 'townk/vim-autoclose'
    
    "> Go
    Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } " https://github.com/fatih/vim-go
    Plug 'neoclide/coc.nvim', {'branch': 'release'}     " https://github.com/neoclide/coc.nvim
    Plug 'SirVer/ultisnips'                             " https://github.com/sirver/UltiSnips
    
    "> Theme
    Plug 'NLKNguyen/papercolor-theme' " https://github.com/NLKNguyen/papercolor-theme
call plug#end()

"-- plug END

" ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" vim-gitgutter

set updatetime=500

"-- vim-gitgutter END

" papercolor-theme

set termguicolors
set background=dark
colorscheme PaperColor

"-- papercolor-theme END 
"
"-- vim-go specific configuration

source ~/.config/nvim/langs/go.vim
source ~/.config/nvim/langs/ts.vim


