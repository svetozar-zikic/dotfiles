set number
syntax on
set ignorecase
set smartcase
noremap <silent> <F12> :set number!<CR>
inoremap <silent> jk <ESC>
inoremap <silent> jj <ESC>

no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>

autocmd filetype yaml setlocal ai ts=2 sts=2 sw=2 et
