lua require 'init'

"===================================================
"================== AUTO-STUFF =====================
"===================================================
set autowriteall
au FocusLost * silent! wa

if has('persistent_undo')
  set undolevels=5000
  set undodir="$HOME/.config/nvim/.NVIM_UNDO_FILES"
  set undofile
endif

augroup remember_folds
autocmd!
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent! loadview
augroup END

augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

autocmd BufWinEnter * setlocal modifiable

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
"************************************************************
"************************************************************
"============================================================
"=====================  CUSTOM MAPPINGS =====================
"============================================================
"************************************************************
"************************************************************

" TELESCOPE
nmap <leader>ma :lua require('telescope.builtin').marks({layout_strategy='horizontal',path_display={"tail"}, layout_config={width=130, preview_width=0.6}})<CR>
" nmap <leader><leader>b :lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown({layout_config={width=130}}))<CR>
" nmap \ :lua require('telescope.builtin').file_browser({layout_strategy='horizontal', layout_config={width=130, preview_width=0.6}})<CR>
" FOLDING
nnoremap <expr> <f9> &foldlevel ? 'zM' :'zR'
