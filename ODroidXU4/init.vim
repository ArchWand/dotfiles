call plug#begin()

Plug 'preservim/nerdcommenter'
Plug 'gcmt/taboo.vim'
Plug 'lukas-reineke/indent-blankline.nvim'

call plug#end()

" ##### SETTINGS #####
syntax enable
filetype plugin on

""" Buffer settings
" Mouse
set mouse=a

" Indenting
set autoindent smarttab
set tabstop=4 shiftwidth=4 softtabstop=4
set breakindent

" Ensure word wrap does not split words
set formatoptions=l
set lbr

" Set the leader as space
let mapleader=" "
let maplocalleader=" "
nnoremap <Space> <Nop>

" Line numbers
set number relativenumber
autocmd BufReadPre,FileReadPre,WinEnter,FocusGained * :setlocal number relativenumber
autocmd WinLeave,FocusLost * :setlocal number norelativenumber
command NumberToggle :setlocal relativenumber!

" Clipboard
set clipboard=unnamedplus

" Some servers have issues with backup files, see #649.
set nobackup nowritebackup

" Default split direction
set splitbelow splitright

" Code folding
set foldmethod=syntax
set foldlevel=20

" Scrolling
set scrolloff=4
set scroll=1


""" Utility
" Reload vimrc
command Rvrc source $MYVIMRC


""" Ease of Use
" Close all windows
nnoremap ZA :wqa<CR>

" Insert mode save
" Use Ctrl-s for saving
noremap <C-s> :update<CR>
inoremap <C-s> <C-o>:update<CR>
noremap <C-A-s> :wa<CR>
inoremap <C-A-s> <C-O>:wa<CR>

" Browsing
nnoremap ]b :n<CR>
nnoremap [b :N<CR>

" Single insertion/append
function SingleInsert(type, char, count)
	return "normal " . a:type . repeat(a:char, a:count)
endfunction
nnoremap <leader>i :<C-U>exec SingleInsert("i", nr2char(getchar()), v:count1)<CR>
nnoremap <leader>a :<C-U>exec SingleInsert("a", nr2char(getchar()), v:count1)<CR>
nnoremap <leader>I :<C-U>exec SingleInsert("I", nr2char(getchar()), v:count1)<CR>
nnoremap <leader>A :<C-U>exec SingleInsert("A", nr2char(getchar()), v:count1)<CR>
" Single change
vnoremap <leader>c :<C-U>exec SingleInsert("`<cv`>", nr2char(getchar()), v:count1)<CR>

" Vertical split terminal
command Vterm :vsp|:term

" Move lines
nnoremap <expr> <A-k> ":m -" . (v:count ? v:count-1 : 2) . "<CR>"
nnoremap <expr> <A-j> ":m +" . (v:count ? v:count : 1) . "<CR>"
nmap <A-Up> <A-k>
nmap <A-Down> <A-j>
imap <A-j> <C-o><A-j>
imap <A-k> <C-o><A-k>
imap <A-Down> <C-o><A-j>
imap <A-Up> <C-o><A-k>

" Auto-bracketing
vnoremap <leader>s( x<Esc>i()<Esc>P
vmap <leader>s) <leader>s(
vnoremap <leader>s[ x<Esc>i[]<Esc>P
vmap <leader>s] <leader>s[
vnoremap <leader>s{ x<Esc>i{}<Esc>P
vmap <leader>s} <leader>s{
vnoremap <leader>s< x<Esc>i<><Esc>P
vmap <leader>s> <leader>s<
vnoremap <leader>s' x<Esc>i''<Esc>P
vnoremap <leader>s" x<Esc>i""<Esc>P
vnoremap <leader>s` x<Esc>i``<Esc>P


""" Movement
" Wrapped movement
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
vnoremap <expr> j v:count == 0 ? 'gj' : 'j'
vnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nmap <Down> j
nmap <Up> k
vmap <Down> j
vmap <Up> k
imap <Down> <C-o>j
imap <Up> <C-o>k

" Convenient BoL EoL
function WinTextWidth()
	let winwidth = winwidth(0)
	let winwidth -= (max([len(line('$')), &numberwidth]) * (&number || &relativenumber))
	let winwidth -= &foldcolumn
	redir => signs
	execute 'silent sign place buffer=' . bufnr('%')
	redir END
	if signs !~# '^\n---[^\n]*\n$'
		let winwidth -= 2
	endif
	return winwidth
endfunction
function WhitespaceLen()
	let out=strdisplaywidth(getline('.')[:match(getline('.'),'\S')-1])
	if out == strdisplaywidth(getline('.'))
		let out=0
	endif
	return out
endfunction
function GoBoL()
	let winwidth = WinTextWidth()
	let whitelen = WhitespaceLen()

	if virtcol('.') % winwidth - whitelen == 1
		return virtcol('.') > winwidth ? '^' : '0'
	else
		return 'g^'
	endif
endfunction
function GoEoL()
	let winwidth = WinTextWidth()

	if virtcol('.') % winwidth == 0
		return '$'
	else
		return 'g$'
	endif
endfunction

noremap <expr> H v:count ? 'H' : GoBoL()
noremap <expr> L v:count ? 'L' : GoEoL()
nmap <Home> H
nmap <End> L
imap <Home> <C-o><Home>
imap <End> <C-o><End>


""" Registers
" More convenient registers
noremap 0 "0
noremap _ "_

" Normal send to 0
nnoremap d "0d
nnoremap D "0D
nnoremap c "0c
nnoremap C "0C
nnoremap s "0s
nnoremap S "0S
nnoremap x "0x
nnoremap X "0X

" Visual send to 0
vnoremap d "0d
vnoremap D "0D
vnoremap c "0c
vnoremap C "0C
vnoremap s "0s
vnoremap S "0S
vnoremap x "0x
vnoremap X "0X



" ##### PLUGINS #####

" NerdCommenter
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Taboo
" Remember tab names
set sessionoptions+=tabpages,globals
