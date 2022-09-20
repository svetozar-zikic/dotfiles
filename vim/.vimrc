set number
set relativenumber
syntax on
set ignorecase
set smartcase
set noai
noremap <silent> <F12> :set number!<CR>
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

let g:terraform_fmt_on_save=1
""" let g:terraform_align=1
""" autocmd BufEnter *.tf* colorscheme icansee
