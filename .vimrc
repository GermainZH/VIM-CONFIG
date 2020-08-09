"Defaults---
set noswapfile
set nocompatible
set mouse=a
set tabstop=4
set shiftwidth=4
set smarttab
set autoindent
set smartindent
set cindent
set showcmd
set number
set nowrap
set clipboard=unnamedplus
set ruler
set number
set showmode
syntax on
"---

"Theme---
colorscheme koehler 
"

"To clipboard---
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
	augroup WSLYank
		autocmd!
		autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
	augroup END
endif
"---

"Plugins---
call plug#begin('~/.vim/plugged')
	Plug 'jiangmiao/auto-pairs'
	Plug 'neoclide/coc.nvim',{'branch':'release'}
call plug#end()
"---

"Snippets tab to jump---
noremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
    endfunction
let g:coc_snippet_next = '<tab>'
"---

"Compiler maps---
map zz :!g++ -std=c++17 -g % -o %:r <bar> clear <CR>
map xx :!g++ -std=c++17 -g -Wall -Wextra -pedantic -O2 -Wshadow -Wformat=2 -Wfloat-equal -Wconversion -Wlogical-op -Wshift-overflow=2 -Wduplicated-cond -Wcast-qual -Wcast-align -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -D_FORTIFY_SOURCE=2 -fsanitize=address -fsanitize=undefined -fno-sanitize-recover -fstack-protector % -o %:r <bar> clear <CR>
map cc :!./%:r <CR>
"---
