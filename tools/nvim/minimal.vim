set mouse=a
" set clipboard=unnamedplus
set number relativenumber
set ignorecase smartcase incsearch hlsearch
set splitright splitbelow
set virtualedit+=onemore

noremap <expr> j v:count ? "j" : "gj"
noremap <expr> k v:count ? "k" : "gk"

nnoremap H ^
xnoremap H ^
nnoremap L $
xnoremap L $

nnoremap MH H
nnoremap MM M
nnoremap ML L

noremap y "+y
nmap Y "+Y
noremap p "+p
noremap P "+P

nnoremap crn *Ncgn
nnoremap U <C-r>
let mapleader=' '
nnoremap <leader>p <Cmd>let @+=@"<CR>
command R source $MYVIMRC

nnoremap <C-s> :update<CR>
inoremap <C-s> <Esc>:update<CR>
onoremap <C-a> <Cmd>normal! m9ggVG<CR><Cmd>normal! `9<CR>

nnoremap <A-S-h> Xph
nnoremap <A-S-l> xp
vnoremap <A-S-h> xhPgvhoho
vnoremap <A-S-l> xpgvlolo

nnoremap <expr> <A-j> "<Cmd>m +".v:count1."<CR>"
nnoremap <expr> <A-k> "<Cmd>m -".(v:count1+1)."<CR>"
inoremap <expr> <A-j> "<Cmd>m +".v:count1."<CR>"
inoremap <expr> <A-k> "<Cmd>m -".(v:count1+1)."<CR>"
vnoremap <expr> <A-j> ":m '>+".v:count1."<CR>gv"
vnoremap <expr> <A-k> ":m '<-".(v:count1+1)."<CR>gv"

vnoremap < <gv
vnoremap > >gv
nnoremap <A-h> <<
nnoremap <A-l> >>
vmap <A-h> <gv
vmap <A-l> >gv
inoremap <A-h> <C-d>
inoremap <A-l> <C-t>

noremap <C-A-h> <C-w><C-h>
noremap <C-A-j> <C-w><C-j>
noremap <C-A-k> <C-w><C-k>
noremap <C-A-l> <C-w><C-l>
nnoremap <A-i> <C-w>p
inoremap <A-i> <Cmd>wincmd p<CR>

unmap y
nunmap Y
unmap p
unmap P

function! SmartReg(key)
  return (v:register == '"' ? '"+' : '') . a:key
endfunction
nnoremap <expr> y SmartReg('y')
xnoremap <expr> y SmartReg('y')
nnoremap <expr> Y SmartReg('y$')
nnoremap <expr> p SmartReg('p')
xnoremap <expr> p SmartReg('p')
nnoremap <expr> P SmartReg('P')
xnoremap <expr> P SmartReg('P')

" "Smart" home
" Go to the beginning of the line
function! GoBoL()
  let pos1 = col('.')
  normal! g^
  let pos2 = col('.')
  if pos1 == pos2
    normal! ^
    let pos1 = col('.')
    if pos1 == pos2
      normal! 0
    endif
  endif
endfunction

" "Smart" end
" Go to the end of the line
function! GoEoL()
  let pos = col('.')
  normal! g$
  if col('.') == pos
    normal! $
  endif
  if col('.') == len(getline('.'))
    let curpos = getpos('.')
    let curpos[4] = v:maxcol " set curswant
    call setpos('.', curpos)
  endif
endfunction

nunmap H
xunmap H
nunmap L
xunmap L

nnoremap H <Cmd>call GoBoL()<CR>
xnoremap H <Cmd>call GoBoL()<CR>
nnoremap L <Cmd>call GoEoL()<CR>
xnoremap L <Cmd>call GoEoL()<CR>

