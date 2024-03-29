" ArcWand's neovim vimrc
call plug#begin()

Plug 'dstein64/vim-startuptime'

" Autocompletion
Plug 'github/copilot.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dkarter/bullets.vim'
" Plug 'm4xshen/autoclose.nvim'

" Rendering
Plug 'lervag/vimtex'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install', 'for': 'markdown' }
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'jalvesaq/Nvim-R', { 'for': 'r'}
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate'}
Plug 'chrisbra/Colorizer'
Plug 'tyru/open-browser.vim'

" Utility
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'gcmt/taboo.vim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'mg979/vim-visual-multi'
Plug 'mbbill/undotree'
Plug 'lambdalisue/suda.vim'
Plug 'jbyuki/instant.nvim'
Plug 'tpope/vim-fugitive'

" Visual
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

call plug#end()

" ##### THEME #####

set termguicolors
colorscheme catppuccin-mocha

" ##### SETTINGS #####
syntax enable
filetype plugin indent on

set colorcolumn=80

""" Indentation
set autoindent smarttab
set noexpandtab
set tabstop=4 shiftwidth=4 softtabstop=4
set breakindent

" .java - java program
autocmd FileType java setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
" .md - markdown
autocmd FileType markdown setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
" .py - python script
autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
" .R - R script
autocmd FileType r setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
" .s - ASM
autocmd FileType asm setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
" .tex - LaTeX
autocmd FileType tex setlocal colorcolumn=80 expandtab tabstop=1 shiftwidth=1 softtabstop=1

""" Buffer settings
" Mouse
set mouse=a

" Highlight line and column
set cursorline cursorcolumn

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
" set smoothscroll
set scrolloff=4

" Default conceal level
set conceallevel=0


""" Utility
" Reload vimrc
command R source $MYVIMRC

" Sync todo list manually
command TodoSync !/home/arcwand/scripts/todo_sync.sh

" Visualize whitespace
command WhitespaceToggle :set list!<CR>

" Toggle relative numbering
nnoremap <leader>n :NumberToggle<CR>

" Toggle word wrap
nnoremap <leader>w :set wrap!<CR>

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
" Single substitution
vnoremap <leader>s :<C-U>exec SingleInsert("`<cv`>", nr2char(getchar()), v:count1)<CR>
" Single newline
nnoremap <expr> <leader>o "m'" . (v:count) . "o<Esc>`'"
nnoremap <expr> <leader>O "m'" . (v:count) . "O<Esc>`'"

" Vertical split terminal
command Vterm :vsp|:term
" Exit terminal mode
tnoremap <Esc> <C-\><C-n>

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
nnoremap <M-S-i> <C-w><S-w>


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

	if virtcol('.') % winwidth == 0 || !&wrap
		return '$'
	else
		return 'g$'
	endif
endfunction

noremap <expr> <HOME> GoBoL()
noremap <expr> <END> GoEoL()
nmap <expr> H v:count ? 'H' : '<Home>'
nmap <expr> L v:count ? 'L' : '<End>'
vmap <expr> H v:count ? 'H' : '<Home>'
vmap <expr> L v:count ? 'L' : '<End>'
onoremap <expr> H v:count ? 'H' : '<Home>'
onoremap <expr> L v:count ? 'L' : '<End>'


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
xnoremap <silent> p p:let @1=@+<CR>gvy:let @0=@1<CR>



" ##### PLUGINS #####

" --- Autocompletion ---
" CoC
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <expr><TAB> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "<CR>"

" Use <c-space> to trigger completion
if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Disable CoC
nnoremap <leader>cd :<C-u>CocDisable<CR>
autocmd FileType markdown let b:coc_enabled=0

" Copilot
let g:copilot_enabled = v:false
nnoremap <C-A-p> :Copilot disable<CR>
imap <C-A-p> <C-o><C-A-p>
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

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

" Treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the first five listed parsers should always be installed)
  ensure_installed = { "bash", "c", "cpp", "css", "diff", "git_config", "git_rebase", "gitcommit", "gitignore", "html", "http", "ini", "java", "java", "javascript", "json", "latex", "lua", "luadoc", "make", "markdown_inline", "python", "r", "rasi", "regex", "rust", "sxhkdrc", "vim", "vimdoc" },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  -- ignore_install = { },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

	disable = { "latex", "ini" },
    -- disable = function(lang, buf)
    --     local max_filesize = 1024 * 1024 -- 1 GB
    --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --     if ok and stats and stats.size > max_filesize then
    --         return true
    --     end
    -- end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    -- additional_vim_regex_highlighting = false,
  },
}
EOF

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

" NvimTree
lua << EOF
require'nvim-tree'.setup {
}
EOF
" Mappings
nnoremap <leader>e :NvimTreeToggle<CR>

" Reenable gx after loading nvim-tree
nnoremap gx <CMD>execute '!xdg-open ' .. shellescape(expand('<cfile>'), v:true)<CR>

" UndoTree
nnoremap <leader>u :UndotreeToggle<CR>

" Instant
let g:instant_username = "arcwand"


" --- Visual ---
" Indent Blankline
lua << EOF
require("ibl").setup()
EOF

" Vim-Airline
let g:airline_theme='violet'
let g:airline_powerline_fonts = 1
" Allow spaces for alignment
let g:airline#extensions#whitespace#mixed_indent_algo = 2
" But also no one cares about errant spaces
let g:airline#extensions#whitespace#enabled = 0

