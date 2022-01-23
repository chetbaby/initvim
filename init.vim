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

"=============================================
"===============  FZF Stuff    ===============
"=============================================

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '-G ".*\.(js|jsx|json|ts|tsx|html|css|scss|md|txt|yml)$"', <bang>0)
command! -bar -bang Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter=: --nth=4..'}, 'right'), <bang>0)
" command! -bang -nargs=? -complete=dir Files
"     \ call fzf#vim#files(<q-args>, {'options': ['--info=inline', '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)

" FZF Floating window
function! FloatingFZF()
let buf = nvim_create_buf(v:false, v:true)
call setbufvar(buf, '&signcolumn', 'no')
" reduced height for laptop to fit window
let height = float2nr(30)
let width = float2nr(150)
let horizontal = float2nr((&columns - width) / 2)
let vertical = 1
let opts = {
      \ 'relative': 'editor',
      \ 'row': vertical,
      \ 'col': horizontal,
      \ 'width': width,
      \ 'height': height,
      \ 'style': 'minimal'
      \ }
call nvim_open_win(buf, v:true, opts)
endfunction

"=============================================
"==================   Coc   ==================
"=============================================
function! s:check_back_space() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if exists('*complete_info')
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
let g:netrw_altv=1
" for when coc hangs
autocmd VimLeavePre * :call coc#rpc#kill()
  autocmd VimLeave * if get(g:, 'coc_process_pid', 0) | call system('kill -9 -'.g:coc_process_pid) | endif

" Create new folder/file...use `:E folder/file`
command -nargs=1 E execute('silent! !mkdir -p "$(dirname "<args>")"') <Bar> e <args>

" hover fn
" function! ShowDocIfNoDiagnostic(timer_id)
"   if (coc#float#has_float() == 0 && CocHasProvider('hover') == 1)
"     silent call CocActionAsync('doHover')
"   endif
" endfunction

" function! s:show_hover_doc()
"   call timer_start(500, 'ShowDocIfNoDiagnostic')
" endfunction

" autocmd CursorHoldI * :call <SID>show_hover_doc()
" autocmd CursorHold * :call <SID>show_hover_doc()
"================================================
"============  PLUGIN CONFIGURATIONS ============
"================================================

" let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:rainbow_active = 1
let g:closetag_filenames = '*.html,*.xhtml,*.js,*.jsx,*.phtml'
let g:tagalong_filetypes = ['html', 'xml', 'jsx', 'eruby', 'ejs', 'eco', 'php', 'htmldjango', 'javascriptreact', 'typescriptreact']
let g:tagalong_additional_filetypes = ['js', 'javascript']
let g:tagalong_verrose = 1
let g:Hexokinase_highlighters = ['backgroundfull']
let g:mta_filetypes = {
  \ 'html' : 1,
  \ 'xhtml' : 1,
  \ 'javascript' : 1,
  \ 'javascriptreact' : 1,
  \ 'xml' : 1,
  \ 'jinja' : 1,
  \}
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

"************************************************************
"************************************************************
"============================================================
"=====================  CUSTOM MAPPINGS =====================
"============================================================
"************************************************************
"************************************************************

" TELESCOPE
nmap <leader>fi :lua require('telescope.builtin').find_files({layout_strategy='horizontal',path_display={"tail"}, layout_config={width=130, preview_width=0.6}})<CR>
nmap <leader>L :Ag<CR>
nmap <leader>ff :lua require('telescope.builtin').live_grep({layout_strategy='horizontal',path_display={"tail"}, layout_config={width=130, preview_width=0.6}})<CR>
nmap <leader>ma :lua require('telescope.builtin').marks({layout_strategy='horizontal',path_display={"tail"}, layout_config={width=130, preview_width=0.6}})<CR>
" nmap <leader><leader>b :lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown({layout_config={width=130}}))<CR>
" nmap \ :lua require('telescope.builtin').file_browser({layout_strategy='horizontal', layout_config={width=130, preview_width=0.6}})<CR>
" FOLDING
nnoremap <expr> <f9> &foldlevel ? 'zM' :'zR'

" COC stuff
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nnoremap <leader>pre :Prettier<CR>
" on a chunk line
nmap gs <Plug>(coc-git-chunkinfo)
nnoremap <f7> :CocRestart<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
"time before popup shows
" set updatetime=300
vmap <leader>for <Plug>(coc-format-selected)
nmap <silent> oo :call CocActionAsync('doHover')<CR>
" autocmd CursorHold * silent call CocActionAsync('doHover')
nmap <leader>die :CocDiagnostics<CR>
nmap <leader>ccon :CocConfig<CR>
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
nmap <F2> <Plug>(coc-rename)
" nmap <leader><leader>f <Plug>(coc-fix-current)
nmap <leader>ac  <Plug>(coc-codeaction)
" nmap <leader><leader>act <Plug>(coc-codeaction)
nmap <leader><leader>n <Plug>(coc-diagnostic-next)
" ???
nmap <leader>bb <C-^> "
