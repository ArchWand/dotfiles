" System
set mouse=a
" set clipboard=unnamedplus " prevent deletions from clobbering system clipboard
set undofile
set updatetime=250
" set notimeout timeoutlen=1000 " Managed by which-key
set shada=!,%,'100,s10,h
set noautoread

" Display
let g:have_nerd_font=v:true
set number relativenumber
set cursorline cursorcolumn
set colorcolumn=80
set scrolloff=7
set showmode
" set inccommand=nosplit
set signcolumn=yes
set conceallevel=0
set listchars=eol:$,tab:>-,space:.
set listchars+=multispace:---+,lead:.,trail:~
set listchars+=extends:>,precedes:<,nbsp:␣

" Default indentations
set noexpandtab
set     tabstop=4
set  shiftwidth=4
set softtabstop=4

" Folding
let g:markdown_folding = 1
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=999

" Word wrapping
set wrap linebreak breakindent
" set showbreak=\ >\ 
set textwidth=80

" Behavior
set ignorecase smartcase incsearch hlsearch
set splitright splitbelow
set formatexpr=lua.require'conform'.formatexpr()
set formatoptions=c/qnj
set nomodeline
set virtualedit+=onemore
set whichwrap=h,l

