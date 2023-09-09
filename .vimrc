""""""""""""""""""""""""""""""""""""""""""""""""
""                    VIM                     ""
""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf8                     " Vim stores all data (including the exchange buffer) in UTF8
set termencoding=utf-8                " Terminal encoding
set fileencodings=utf8,cp1251,koi8-r  " list of encodings that Vim will cycle while file opening

" Syntax highlighting enables.
if has("syntax")
  syntax on " https://stackoverflow.com/questions/19030290/syntax-highlighting-causes-terrible-lag-in-vim
endif

" use a tab width of 2 space chars
set tabstop=2                         " tab is displayed as 4 spaces in text
set shiftwidth=2                      " indents will have a width of 4.
set softtabstop=2                     " Sets the number of columns for a TAB.
set expandtab                         " Expand TABs to spaces.

" Relative line numbers for the normal mode, ans absolute line numbers for the insert mode.
" https://jeffkreeftmeijer.com/vim-number/
set number

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" Line length marker
set colorcolumn=80
highlight ColorColumn ctermbg=darkgray

set backspace=indent,eol,start        " Make backspace work like most other apps

set showmatch                         " Move the cursor to the previous matching bracket for half a second

set hlsearch                          " Turns on search highlighting
set incsearch                         " Start searching when you type

set pastetoggle=<F2>                  " Paste toggle

map <A-z> :set wrap!<CR>              " WordWrap toggle


""""""""""""""""""""""""""""""""""""""""""""""""
""                   VUNDLE                   ""
""""""""""""""""""""""""""""""""""""""""""""""""
" Set up:
"  $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" Brief help
"  :PluginList       - lists configured plugins
"  :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
"  :PluginSearch foo - searches for foo; append `!` to refresh local cache
"  :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()           " Keep Plugin commands between vundle#begin/end.

Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'  " plugins on GitHub repo
Plugin 'bling/vim-airline'
Plugin 'majutsushi/tagbar'

call vundle#end()             " required
filetype plugin indent on     " required


""""""""""""""""""""""""""""""""""""""""""""""""
""                  NERDTree                  ""
""""""""""""""""""""""""""""""""""""""""""""""""
"let NERDTreeIgnore=['\.pyc$']
silent! nmap <C-p> :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>

let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeMapPreview="<F4>"


""""""""""""""""""""""""""""""""""""""""""""""""
""                  AIRLINE                   ""
""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs"


""""""""""""""""""""""""""""""""""""""""""""""""
""                  TAGBAR                    ""
""""""""""""""""""""""""""""""""""""""""""""""""
" sudo apt-get install ctags
nnoremap <silent> <F8> :TagbarToggle<CR>

" open if you're opening Vim with a supported file/files
autocmd VimEnter * nested :call tagbar#autoopen(1)
