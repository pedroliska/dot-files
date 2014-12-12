"comment lines start with doublequote

set clipboard=unnamed
set hlsearch
set ignorecase
set smartcase
set incsearch
set nocp
set ts=2  " Tabs are 2 spaces
set bs=2  " Backspace over everything in insert mode
set shiftwidth=2  " Tabs under smart indent
set number
set vsvim_useeditordefaults
:set scrolloff=8

map <Space> :noh<CR>
map <C-u> <PageUp>
map <C-m> <PageDown>

"make asterisk search not go to the next search result
nnoremap * *``

set backspace=indent,eol,start