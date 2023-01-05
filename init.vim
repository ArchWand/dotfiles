call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf.vim'
Plug 'lervag/vimtex'
Plug 'preservim/nerdcommenter'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'github/copilot.vim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'gcmt/taboo.vim'

Plug 'EdenEast/nightfox.nvim'

call plug#end()

" ##### THEME #####

syntax on
colorscheme carbonfox

" ##### SETTINGS #####
filetype plugin on

""" Buffer settings
" Indenting
set autoindent smarttab
set tabstop=4 shiftwidth=4 softtabstop=4
set breakindent

" Ensure word wrap does not split words
set formatoptions=l
set lbr

" Set the leader as space
let mapleader=" "
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
function GoBoL()
    let winwidth = WinTextWidth()
    let whitelen = strdisplaywidth(getline('.')[:match(getline('.'),'\S')-1])

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

" Visual paste fix
vnoremap p p:<C-u>let @1=@0<CR>:<C-u>let @+=@0<CR>:<C-u>let @0=@"<CR>



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

" Copilot
let g:copilot_enabled = v:false
nnoremap <C-A-p> :Copilot disable<CR>
imap <C-A-p> <C-o><C-A-p>

" VimTex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'

" Vim-Airline
let g:airline_theme='violet'
let g:airline_powerline_fonts = 1

" Markdown Preview
let g:mkdp_auto_start = 0

" CoC
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

