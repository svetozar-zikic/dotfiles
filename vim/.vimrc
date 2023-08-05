set number
set relativenumber
syntax on
set ignorecase
set smartcase
set noai
map <S-F12> :set number! number?<CR>
map <S-F11> :set relativenumber! relativenumber?<CR>
inoremap <silent> jk <ESC>
inoremap <silent> jj <ESC>
inoremap <silent> CapsLock <ESC>

no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>

autocmd filetype yaml setlocal noai ts=2 sts=2 sw=2 et
autocmd filetype yml setlocal noai ts=2 sts=2 sw=2 et
autocmd filetype *.tf* setlocal noai ts=2 sts=2 sw=2 et
