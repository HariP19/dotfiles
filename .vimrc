"       _
"      (_)
"__   ___ _ __ ___  _ __ ___
"\ \ / / | '_ ` _ \| '__/ __|
" \ V /| | | | | | | | | (__
"  \_/ |_|_| |_| |_|_|  \___|
"

"============================================================
" Vundle Plugins
"
" To install from Vundle
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"
" To install Vundle plugins
" Launch vim and run :PluginInstall
"
" set the runtime path to include Vundle and initialize
"	set nocompatible              " be iMproved, required
"	filetype off                  " required
"
"	set rtp+=~/.vim/bundle/Vundle.vim
"	call vundle#begin()

" let Vundle manage Vundle, required
"	Plugin 'VundleVim/Vundle.vim'

" vim-code-dark
"	Plugin 'tomasiser/vim-code-dark'

" NerdTree
"	Plugin 'preservim/nerdtree'
	
" NerdCommenter
"	Plugin 'scrooloose/nerdcommenter'

"	call vundle#end()
"	filetype plugin indent on
"=============================================================

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

" Enable mouse on all modes
	set mouse=a

" Set colorscheme to vim-code-dark
"	colorscheme codedark

" Start NERDTree and put the cursor back in the other window.
	autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window remaining in the only tab.
	autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Open the existing NERDTree on each new tab.
	autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

"===============================================================
" Remappings

	inoremap jj <ESC> " leave insert mode with jj
