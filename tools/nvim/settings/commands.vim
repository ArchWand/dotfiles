" User Commands

" Reload vimrc
command R source $MYVIMRC

" Vertical split terminal
command Vterm vsp|term

" Hex editing
command -bar Hexmode call ToggleHex()

" Autocommands

" Highlight when yanking text
"  See `:help vim.highlight.on_yank()`
au TextYankPost * silent! lua vim.highlight.on_yank {timeout=150}

" Configure termianl buffers
au TermOpen * setlocal nonumber norelativenumber scrolloff=0

" Make sure formatoptions don't get overriden by defaults
au BufEnter * set formatoptions=c/qnj

" Enable ftplugin for filetype= (no filetype)
function CallIfEmpty()
    " If no filename, file doesn't exist, or file is empty
    if @% == "" || filereadable(@%) == 0 || (line('$') == 1 && col('$') == 1)
        set ft=noft
    endif
endfunction

au VimEnter * call CallIfEmpty()

" Hex editing
" autocmds to automatically enter hex mode and handle file writes properly
if has("autocmd")
  " vim -b : edit binary using xxd-format!
  augroup Binary
    au!

    " " set binary option for all binary files before reading them
    " au BufReadPre *.bin,*.hex setlocal binary

    " if on a fresh read the buffer variable is already set, it's wrong
    au BufReadPost *
          \ if exists('b:editHex') && b:editHex |
          \   let b:editHex = 0 |
          \ endif

    " convert to hex on startup for binary files automatically
    au BufReadPost *
          \ if &binary | Hexmode | endif

    " When the text is freed, the next time the buffer is made active it will
    " re-read the text and thus not match the correct mode, we will need to
    " convert it again if the buffer is again loaded.
    au BufUnload *
          \ if getbufvar(expand("<afile>"), 'editHex') == 1 |
          \   call setbufvar(expand("<afile>"), 'editHex', 0) |
          \ endif

    " before writing a file when editing in hex mode, convert back to non-hex
    au BufWritePre *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd -r" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif

    " after writing a binary file, if we're in hex mode, restore hex mode
    au BufWritePost *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd" |
          \  exe "set nomod" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif
  augroup END
endif
