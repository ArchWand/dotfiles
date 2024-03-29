" ArcWand's neovim vimrc
call plug#begin()

Plug 'dstein64/vim-startuptime'

" Autocompletion
Plug 'github/copilot.vim'
Plug 'dkarter/bullets.vim'

" Utility
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'gcmt/taboo.vim'
Plug 'mg979/vim-visual-multi'
Plug 'mbbill/undotree'
Plug 'lambdalisue/suda.vim'

" Visual
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

call plug#end()

" ##### THEME #####

set termguicolors
" colorscheme catppuccin-mocha

" ##### SETTINGS #####
syntax enable
filetype plugin indent on

""" Indentation
set autoindent smarttab
set noexpandtab
set tabstop=4 shiftwidth=4 softtabstop=4
set breakindent

" .py - python script
autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
" .R - R script
autocmd FileType r setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
" .s - ASM
autocmd FileType asm setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

""" Buffer settings
" Mouse
set mouse=a

" Visualize whitespace
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" Ensure word wrap does not split words
set formatoptions=l
set lbr

" Search settings
set ignorecase smartcase

" Set the leader as space
let mapleader=" "
let maplocalleader="\\"
nnoremap <Space> <Nop>

" Line numbers
set number relativenumber
command NumberToggle :setlocal relativenumber!
" Switch to not relative when focus lost
" autocmd BufReadPre,FileReadPre,WinEnter,FocusGained * :setlocal number relativenumber
" autocmd WinLeave,FocusLost * :setlocal number norelativenumber

" Clipboard
set clipboard=unnamedplus

" Some servers have issues with backup files, see #649.
set nobackup nowritebackup

" Default split direction
set splitbelow splitright

" Code folding
set foldmethod=manual
set foldlevel=20

" Scrolling
set scrolloff=4
set scroll=1

" Default conceal level
set conceallevel=2


""" Utility
" Reload vimrc
command R source $MYVIMRC

" Visualize whitespace
nnoremap <leader>w :set list!<CR>

" Toggle relative numbering
nnoremap <leader>n :NumberToggle<CR>

" Toggle word wrap
nnoremap <leader>o :set wrap!<CR>

" Persistent undo
set undofile
set undodir=~/.local/share/nvim/undos


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
nnoremap <expr> <A-k> ":<C-u>m -" . (v:count ? v:count+1 : 2) . "<CR>"
nnoremap <expr> <A-j> ":<C-u>m +" . (v:count ? v:count : 1) . "<CR>"
vnoremap <expr> <A-k> ":m '<-" . (v:count ? v:count+1 : 2) . "<CR>gv"
vnoremap <expr> <A-j> ":m '>+" . (v:count ? v:count : 1) . "<CR>gv"
nmap <A-Up> <A-k>
nmap <A-Down> <A-j>
vmap <A-Up> <A-k>
vmap <A-Down> <A-j>
imap <A-j> <C-o><A-j>
imap <A-k> <C-o><A-k>
imap <A-Down> <C-o><A-j>
imap <A-Up> <C-o><A-k>

" Move characters
nnoremap <A-h> xhP
nnoremap <A-l> xp
imap <A-h> <Esc><A-h>a
imap <A-l> <Esc><A-l>a

" Cycle focus
nnoremap <M-i> <C-w>w


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

" Provide a method for unwrapped movement
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k

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

	if virtcol('.') % winwidth - whitelen == 1 || !&wrap
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

" Visual paste
xnoremap <silent> p p:let @+=@0<CR>:let @0=@"<CR>



" ##### PLUGINS #####

" --- Autocompletion ---
" Copilot
let g:copilot_enabled = v:false
nnoremap <C-A-p> :Copilot disable<CR>
imap <C-A-p> <C-o><C-A-p>
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" Ultisnips
let g:UltiSnipsExpandTrigger="<C-p>"
" let g:UltiSnipsJumpForwardTrigger="<C-f>"
" let g:UltiSnipsJumpBackwardTrigger="<C-z>"
" let g:UltiSnipsEditSplit="vertical"

" Bullets
let g:bullets_enabled_file_types = [
			\ 'markdown',
			\ 'text',
			\ 'gitcommit',
			\ 'scratch'
			\]
let g:bullets_enable_in_empty_buffers = 1


" --- Rendering ---
let g:tex_flavor = "latex"
" VimTex
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0

" Markdown Preview
let g:mkdp_auto_start = 0

" RStudio
let R_objbr_auto_start = 1
let R_assign = 0

" Colorizer
nnoremap <leader>l :ColorToggle<CR>


" --- Utility ---
" NerdCommenter
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
" let g:NERDCommentEmptyLines = 1

" Taboo
" Remember tab names
set sessionoptions+=tabpages,globals

" UndoTree
nnoremap <leader>u :UndotreeToggle<CR>


" --- Visual ---
" Vim-Airline
let g:airline_theme='violet'
let g:airline_powerline_fonts = 1
" Allow spaces for alignment
let g:airline#extensions#whitespace#mixed_indent_algo = 2
" But also no one cares about errant spaces
let g:airline#extensions#whitespace#enabled = 0

