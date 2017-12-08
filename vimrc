""" Options {{{
"" Global {{{
" don't want that good ol' Vi
set nocompatible
" enable plugins
set runtimepath+=$HOME/vimfiles/plugin

" vim config paths {{{
if has('win32')
	let $VIM_DIR = "vimfiles"
else
	let $VIM_DIR = ".vim"
endif

let $MYVIM_DIR = $HOME."/".$VIM_DIR
let $MYVIMRC = $MYVIM_DIR."/vimrc"
" }}}

" enable syntax
syntax on
" enable per project configuration
set exrc
" modern using of backspace in insert mode
set backspace=indent,eol,start
" line numbering
set relativenumber numberwidth=4
" history size
set history=100
" always show status line
set laststatus=2
" Backup files {{{
set backup
let &backupdir = $MYVIM_DIR.'/backup'
" }}}
" Swap files {{{
set swapfile
let &directory = $MYVIM_DIR.'/swap'
" }}}

set nowrap

" Search {{{
set incsearch
set hlsearch
" }}}

" set file encoding to utf-8 if possible
if has("multi_byte")
	set encoding=utf-8
	setglobal fileencoding=utf-8
	set fileencodings=utf-8,latin1
end

set listchars=tab:►\ ,trail:●

if has('gui')
" no gui options
	set guioptions=
endif
" auto commands {{{
augroup number_when_inserting
	autocmd!
	autocmd InsertEnter setlocal norelativenumber number
	autocmd InsertLeave setlocal relativenumber nonumber
augroup END
" }}}
"" }}}
"" Filetype specific {{{
filetype plugin on
" markdown {{{
augroup filetype_markdown
	autocmd!
	autocmd Filetype vim setlocal list listchars=tab:►\ ,trail:●
	autocmd BufNewFile *.txt :write
augroup END
" }}}
" vim {{{
augroup filetype_vim
	autocmd! 
	" autocmd Filetype vim setlocal list listchars=tab:►\ ,trail:●
	autocmd Filetype vim setlocal nolist
	autocmd Filetype vim setlocal textwidth=90
	autocmd FileType vim setlocal nowrap
	autocmd FileType vim setlocal foldmethod=marker
	" Fold every fold at opening
	autocmd FileType vim setlocal foldlevelstart=0
	autocmd FileType vim setlocal autoindent
	autocmd FileType vim setlocal tabstop=2 shiftwidth=2
augroup END
" }}}
" html {{{
augroup filetype_html
	autocmd!
	autocmd BufNewFile, BufRead *.html setlocal nowrap
	autocmd BufWritePre *.html :normal gg=G
augroup END
" }}}
" python {{{
augroup filetype_python
	autocmd!
	" tabs are trailing spaces are displayed
	autocmd FileType python setlocal list
	autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
	autocmd FileType python setlocal textwidth=81 wrapmargin=0 colorcolumn=81
	autocmd FileType python setlocal wrap 
	autocmd FileType python setlocal cindent
	autocmd FileType python :iabbrev <buffer> iff if:<left>
augroup END
" }}}
" cpp {{{
augroup filetype_cpp
	autocmd!
	autocmd FileType cpp setlocal listchars=tab:╬═,trail:●
	autocmd FileType cpp setlocal list
	autocmd FileType cpp setlocal nowrap
	autocmd FileType cpp setlocal cindent
	autocmd FileType cpp setlocal smarttab
	autocmd FileType cpp setlocal foldmethod=indent
	autocmd FileType cpp setlocal foldlevelstart=0
	" insert tabs and display it as 3 spaces wide
	autocmd FileType cpp setlocal tabstop=3 shiftwidth=3 noexpandtab
augroup END
" }}}
" make {{{
augroup filetype_make
	autocmd!
	autocmd Filetype make setlocal tabstop=2 shiftwidth=2
augroup END
" }}}
"" }}}
""" }}}
"""" Mappings {{{
let mapleader = ','

" Global {{{
" select current word in visual mode
noremap <space> viw
" disable arrow keys
noremap <Left> <nop>
noremap <Right> <nop>
noremap <Up> <nop>
noremap <Down> <nop>
" }}}
""" Normal {{{
" navigate through buffers
nnoremap <F5> :buffers<cr>:buffer
" move through splits
nnoremap <A-k> <C-w>k
nnoremap <A-j> <C-w>j
nnoremap <A-l> <C-w>l
nnoremap <A-h> <C-w>h
" undo 2 changes one at a time
nnoremap <leader>d "1dd"2dd:let @"=@1<CR>
"" create splits {{{
" $MYVIMRC {{{
" horizontal
nnoremap <C-s>jv :execute "rightbelow new ".$MYVIMRC<CR>
nnoremap <C-s>kv :execute "leftabove new ".$MYVIMRC<CR>
" vertical
nnoremap <C-s>lv :execute "rightbelow vnew ".$MYVIMRC<CR>
nnoremap <C-s>hv :execute "leftabove vnew ".$MYVIMRC<CR>
" }}}
" new buffer {{{
" horizontal
nnoremap <C-s>ln :execute "rightbelow vnew ."<CR>
nnoremap <C-s>hn :execute "leftabove vnew ."<CR>
" vertical
nnoremap <C-s>jn :execute "rightbelow new ."<CR>
nnoremap <C-s>kn :execute "leftabove new ."<CR>
" }}}
"" }}}
" source file
nnoremap <leader>x :source 
" edit a file
nnoremap <leader>o :e 
" Shortcuts to vimrc file
nnoremap <leader>xv :source $HOME\vimfiles\vimrc<CR><LF>
" go to end of line with Shift-l
nnoremap L $
" go to beginning of line with Shift-h
nnoremap H 0
" save
nnoremap ! :w<CR>
" delete line
nnoremap \ dd
""" }}}
" Visual  {{{
vnoremap <space> e
" exit visual mode
vnoremap jk <Esc>
" capitalize
vnoremap \ U
" add quotes around selection
vnoremap <leader>" <esc>a"<esc>v`<<esc>i"<esc>v
" }}}
" Insert {{{
" delete current line without leaving mode
inoremap <C-d> <esc>ddi
" capitalize current word
inoremap <C-u> <esc>viwU<esc>wi
" move one line up
inoremap <C-j> <esc>ddpi
" move one line down
inoremap <C-k> <esc>kddpki
" exit
inoremap jk <esc>
" unmap default exit
inoremap <esc> <nop>
" }}}
" Pending  {{{
onoremap p i(
onoremap b /return<cr>
" Parentheses {{{
" Inside next
onoremap in( :<C-u>normal! f(vi(<cr>
" Inside last
onoremap il( :<C-u>normal! F)vi(<cr>
" Around next
onoremap an( :<C-u>normal! f(va(<cr>
" Around last
onoremap al( :<C-u>normal! F)va(<cr>
" }}}
" Curly braces {{{
" Inside next
onoremap in{ :<C-u>normal! f{vi{<cr>
" Inside last
onoremap il{ :<C-u>normal! F}vi{<cr>
" Around next
onoremap an{ :<C-u>normal! f{va{<cr>
" Around last
onoremap al{ :<C-u>normal! F}va}<cr>
" }}}
" }}}
"" Filetype specific {{{
let maplocalleader=';'
" help {{{
augroup filetype_help_mappings
	autocmd!
	autocmd Filetype help nnoremap <buffer> <localleader>n :cnext<CR>
	autocmd Filetype help nnoremap <buffer> <localleader>N :cprev<CR>
augroup END
" }}}
" markdown {{{
augroup filetype_markdown_mappings
	autocmd!
	" Inside header block delimited by =
	autocmd FileType markdown onoremap <buffer> ih1 :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>
	" Around header block delimited by =
	autocmd FileType markdown onoremap <buffer> ah1 :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rg_vk0"<cr>
	" Inside subheader block delimited by -
	autocmd FileType markdown onoremap <buffer> ih2 :<c-u>execute "normal! ?^--\\+$\r:nohlsearch\rkvg_"<cr>
	" Around header block delimited by -
	autocmd FileType markdown onoremap <buffer> ah1 :<c-u>execute "normal! ?^--\\+$\r:nohlsearch\rg_vk0"<cr>
augroup END
" }}}
" vim {{{
augroup filetype_vim_mappings
	autocmd!
	autocmd FileType vim inoremap <buffer> fun~ function ()<Return>endfunction:normal k
augroup END
" }}}
" python {{{
augroup filetype_python_mappings
	autocmd!
	" Comment line
	autocmd FileType python nnoremap <buffer> <localleader>c I#<space>:normal
	autocmd FileType python inoremap <buffer> def<C-k> if :<esc>hi
	" PEP 8 tabs
augroup END
" }}}
" cpp {{{
augroup filetype_cpp_mappings
	autocmd!
	autocmd FileType cpp nnoremap <buffer> <localleader>c I//<space>:normal
	autocmd FileType cpp nnoremap <buffer> <localleader>;l :execute "normal! mqA;\<esc>`q"
augroup END
" }}}
"" }}}
"""" }}}
""" Statusline {{{
" absolute filename
set statusline=%-50F
" filetype
set statusline+=%-25.15y
" current percentage for cursor position in whole file
set statusline+=%25p%%
" current line for cursor position in whole file
set statusline+=%54l
set statusline+=/
" line number in whole file
set statusline+=%4L
"" Filetype specific {{{
" cpp {{{
augroup statusline_cpp_filetype
	autocmd!
	" Only filename
	autocmd FileType cpp setlocal statusline=%-30t
	autocmd FileType cpp setlocal statusline+=%3m
	" Byte hexadecimal value of current character
	autocmd FileType cpp setlocal statusline+=%3r
	autocmd FileType cpp setlocal statusline+=\   
	autocmd FileType cpp setlocal statusline+=\{%B
	autocmd FileType cpp setlocal statusline+=:
	" Byte decimal value of current character
	autocmd FileType cpp setlocal statusline+=%b\}
	autocmd FileType cpp setlocal statusline+=\ 
	autocmd FileType cpp setlocal statusline+=[%l
	autocmd FileType cpp setlocal statusline+=/
	autocmd FileType cpp setlocal statusline+=%L]
augroup END
" }}}
"" }}}
""" }}}
""" Abbreviations {{{
"" Filetype Specific
" vim {{{
augroup filetype_vim_abbrev
  autocmd!
augroup end
" }}}
" python {{{
augroup filetype_python_abbrev
  autocmd!
augroup end
" }}}
"" }}}
" Look {{{
if has('gui') && has('win32')
	set guifont=Consolas:h14
	if &g:background ==# 'dark'
		colorscheme twilight
	else
		colorscheme simpleandfriendly
	endif
endif
" }}}
"""" Imported {{{
"" Show syntax highlighting groups for word under cursor {{{
" Mapping {{{
nmap <C-S-P> :call <SID>SynStack()<CR>
" }}}
" Function {{{
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" }}}
"" }}}
"" Fugitive {{{
let g:fugitive_git_command='git'
"" }}}
""" Filetype Specific {{{
"" python {{{
" autocompletion {{{
let g:pydiction_location = $HOME."/vimfiles/autocomplete/dictionary/python"
augroup pydiction
" https://github.com/rkulla/pydiction
	autocmd!
	autocmd FileType python :source $HOME/vimfiles/autocomplete/python.vim
augroup END
" }}}
"" }}}
"" cpp {{{
" syntax highlighting {{{
augroup cpp_syntax_highlighting
	autocmd!
	autocmd FileType cpp let g:cpp_member_variables_highlight=1
	autocmd FileType cpp let g:cpp_class_scope_highlight=1
	autocmd FileType cpp let g:cpp_class_decl_highlight=1
augroup END
" auto
" }}}
" autocompletion
augroup tags_cpp
	autocmd FileType cpp setlocal tags+=$HOME/vimfiles/autocomplete/tags/cpp
augroup END
"" }}}
""" }}}
"""" }}}
