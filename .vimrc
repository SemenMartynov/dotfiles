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
Plugin 'scrooloose/syntastic'
Plugin 'Raimondi/delimitMate'
Plugin 'majutsushi/tagbar'
Plugin 'fatih/vim-go'
Plugin 'taglist.vim'          " plugin from http://vim-scripts.org

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
""                 SYNTASTIC                  ""
""""""""""""""""""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


""""""""""""""""""""""""""""""""""""""""""""""""
""                  TAGBAR                    ""
""""""""""""""""""""""""""""""""""""""""""""""""
" the F8 key will toggle the Tagbar window
nmap <F8> :TagbarToggle<CR>

" Google Go
let g:tagbar_type_go = {
    \ 'ctagstype': 'go',
    \ 'kinds' : [
        \'p:package',
        \'f:function',
        \'v:variables',
        \'t:type',
        \'c:const'
    \]
        \}

""""""""""""""""""""""""""""""""""""""""""""""""
""                  TAGLIST                   ""
""""""""""""""""""""""""""""""""""""""""""""""""
" sudo apt-get install ctags
let Tlist_Use_Right_Window = 1
let Tlist_Use_SingleClick = 1
let Tlist_WinWidth = 40
let Tlist_Compact_Format = 1
nnoremap <F12> :TaglistToggle<CR>


""""""""""""""""""""""""""""""""""""""""""""""""
""                    VIM                     ""
""""""""""""""""""""""""""""""""""""""""""""""""
" Vim stores all data (including the exchange buffer) in UTF8
set encoding=utf8
" Terminal encoding
set termencoding=utf-8
" list of encodings that Vim will cycle while file opening
set fileencodings=utf8,cp1251,koi8-r

" Syntax highlighting enables.
if has("syntax")
  syntax on
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Use filetype detection and file-based automatic indenting.
    filetype plugin indent on
    " Use actual tab chars in Makefiles.
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
endif
" For everything else, use a tab width of 4 space chars.
set tabstop=4		" tab is displayed as 4 spaces in text
set shiftwidth=4	" indents will have a width of 4.
set softtabstop=4   " Sets the number of columns for a TAB.
set expandtab       " Expand TABs to spaces.

set colorcolumn=80  " line length marker
highlight ColorColumn ctermbg=darkgray

" make backspace work like most other apps
set backspace=indent,eol,start

" move the cursor to the previous matching bracket for half a second
set showmatch

" turns on search highlighting
set hlsearch
" start searching when you type
set incsearch

" Paste toggle
set pastetoggle=<F2>

" Wrap toggle
function ToggleWrap()
 if (&wrap == 1)
   set nowrap
 else
   set wrap
 endif
endfunction
map <F9> :call ToggleWrap()<CR>
map! <F9> ^[:call ToggleWrap()<CR>
