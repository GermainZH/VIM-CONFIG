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
set cursorline
syntax on
"---

"Theme---
colorscheme vibrant256
"---

"TabLine--
set showtabline=2 
"---

"StatusLine---
let g:currentmode={ 'n' : 'Normal ', 'no' : 'N·Operator Pending ', 'v' : 'Visual ', 'V' : 'V·Line ', '^V' : 'V·Block ', 's' : 'Select ', 'S': 'S·Line ', '^S' : 'S·Block ', 'i' : 'Insert ', 'R' : 'Replace ', 'Rv' : 'V·Replace ', 'c' : 'Command ', 'cv' : 'Vim Ex ', 'ce' : 'Ex ', 'r' : 'Prompt ', 'rm' : 'More ', 'r?' : 'Confirm ', '!' : 'Shell ', 't' : 'Terminal '}
function! ModeCurrent() abort
    let l:modecurrent = mode()
    let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'V·Block '))
    let l:current_status_mode = l:modelist
    return l:current_status_mode
endfunction
set noshowmode
set laststatus=2
au InsertEnter * hi statusline ctermfg=255 ctermbg=9
au InsertLeave * hi statusline ctermfg=255 ctermbg=201
hi statusline ctermfg=255 ctermbg=201
set statusline=
set statusline+=%0*\ %{ModeCurrent()}\  "mode
set statusline+=%1*\ line:\ %02l\ of\ %L\  "line
set statusline+=%2*\ %<%Y\  "type, modified, readonly, helpfile, preview
set statusline+=%= "right
set statusline+=%2*\ %<%F%m%r%h%w\  "path
set statusline+=%1*\%3p%%\  "percent document
set statusline+=%0*\ %n\  "buffer
hi User1 ctermfg=7 ctermbg=254
hi User2 ctermfg=7 ctermbg=255
hi User3 ctermfg=255 ctermbg=255
hi User4 ctermfg=254 ctermbg=254
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

"Plugins---
call plug#begin('~/.vim/plugged')
	Plug 'jiangmiao/auto-pairs'
	Plug 'neoclide/coc.nvim',{'branch':'release'}
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
