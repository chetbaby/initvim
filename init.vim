lua require 'init'

"===================================================
"================== AUTO-STUFF =====================
"===================================================
" if has('persistent_undo')
"   set undolevels = 5000
"   set undodir = "$HOME/.config/nvim/.NVIM_UNDO_FILES"
"   set undofile
" endif
" autocmd BufWinLeave * noa w!<CR>

" augroup remember_folds
" autocmd!
" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent! loadview
" augroup END

" autocmd BufWinEnter * setlocal modifiable

" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.config/nvim'

if stridx(&runtimepath, expand(vimDir)) == -1
  " vimDir is not on runtimepath, add it
  let &runtimepath.=','.vimDir
endif

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

"=============================================
"============  CUSTOM FUNCTIONS   ============
"=============================================
" Trim Whitespaces
function! TrimWhitespace()
  let l:save = winsaveview()
  %s/\\\@<!\s\+$//e
  call winrestview(l:save)
endfunction

let g:rainbow_active = 1
let g:closetag_filenames = '*.html,*.xhtml,*.js,*.jsx,*.phtml'
let g:tagalong_filetypes = ['html', 'xml', 'jsx', 'eruby', 'ejs', 'eco', 'php', 'htmldjango', 'javascriptreact', 'typescriptreact']
let g:tagalong_additional_filetypes = ['js', 'javascript']
let g:tagalong_verrose = 1
let g:mta_filetypes = {
  \ 'html' : 1,
  \ 'xhtml' : 1,
  \ 'javascript' : 1,
  \ 'javascriptreact' : 1,
  \ 'xml' : 1,
  \ 'jinja' : 1,
  \}


" FOLDING
nnoremap <expr> <f9> &foldlevel ? 'zM' :'zR'
