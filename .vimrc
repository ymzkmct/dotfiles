syntax on

highlight Folded term=standout ctermbg=white ctermfg=black
highlight FoldColumn term=standout ctermbg=white ctermfg=black
set foldmethod=marker

set number
set nonu

set ts=2 sts=2 sw=2 et

set ruler
set number

set hlsearch
set incsearch

set smartindent

set ignorecase


set nowrapscan

let loaded_matchparen = 1

set laststatus=2
set statusline=%<%f\ %m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l/%L,%c%V%8P

