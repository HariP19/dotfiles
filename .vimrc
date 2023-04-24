"       _
"      (_)
"__   ___ _ __ ___  _ __ ___
"\ \ / / | '_ ` _ \| '__/ __|
" \ V /| | | | | | | | | (__
"  \_/ |_|_| |_| |_|_|  \___|
"

"=============================================================
" Configuration Settings
"
" Set syntax detection to on
	syntax on

" Set indentation to on
	set autoindent
	set smartindent

" Set tab 4-spaces-wide
	set tabstop=4

" Set indent to 4-spaces-wide
	set shiftwidth=4

" Enable line numbers
	set number

" Enable relative numbers
	set relativenumber

" Enable mouse on all modes
	set mouse=a

" Set background colorschemej
"set background=dark
set t_Co=256
set t_ut=
colorscheme codedark

" Allow copying to clipboard
	set clipboard^=unnamed,unnamedplus

" Start NERDTree and put the cursor back in the other window.
	autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window remaining in the only tab.
	autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Open the existing NERDTree on each new tab.
	autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

"===============================================================
" Remappings

	inoremap jj <ESC> " leave insert mode with jj


"===============================================================
"Plugins
"
"call plug#being()

"Plug 'AhmedAbdulrahman/vim-aylin'
"
"call plug#end()

