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
colorscheme summerfruit
"---

"Compiler maps---
map zz :!g++ -std=c++17 -g % -o %:r <bar> clear <CR>
map xx :!g++ -std=c++17 -g -Wall -Wextra -pedantic -O2 -Wshadow -Wformat=2 -Wfloat-equal -Wconversion -Wlogical-op -Wshift-overflow=2 -Wduplicated-cond -Wcast-qual -Wcast-align -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -D_FORTIFY_SOURCE=2 -fsanitize=address -fsanitize=undefined -fno-sanitize-recover -fstack-protector % -o %:r <bar> clear <CR>
map cc :!./%:r <CR>
"---

"Wsl2 yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
	augroup WSLYank
		autocmd!
		autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
	augroup END
endif
"---

"Lightline---
let g:lightline = {
      \ 'colorscheme': '16color',
      \ }
set laststatus=2
set noshowmode
"---

"Plugins---
call plug#begin('~/.vim/plugged')
	Plug 'jiangmiao/auto-pairs'
	Plug 'neoclide/coc.nvim',{'branch':'release'}
	Plug 'itchyny/lightline.vim'
call plug#end()
"---

"Coc-snippets tab to next---
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

"Coc-nav 1.enter to select option 2.next option 3.prev. option---
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"---
