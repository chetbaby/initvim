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
let g:vifm_replace_netrw = 1
let g:vifm_replace_netrw_cmd = "Vifm"
let g:vifm_embed_split = 1
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
command! -nargs=0 Prettier :CocCommand prettier.formatFile

"************************************************************
"************************************************************
"============================================================
"=====================  CUSTOM MAPPINGS =====================
"============================================================
"************************************************************
"************************************************************

let mapleader=" "
map <esc> :noh<cr>
nmap <leader>Q :qa!<CR>
nnoremap ; :
nmap <leader>q :BD<CR>
nmap <leader>w :noa w<CR>
nmap <leader>W :w<CR>
nmap <leader>pw :pwd<CR>
nmap <leader>r :so ~/.config/nvim/init.vim<CR>
" nmap <leader>t :call TrimWhitespace()<CR>
nmap <leader>d <Plug>(pydocstring)
nmap <leader>co :Colors<CR>
" nmap <leader>f :Files<CR>
nmap <leader>ff :lua require('telescope.builtin').find_files({layout_strategy='horizontal',path_display={"tail"}, layout_config={width=130, preview_width=0.6}})<CR>
" nmap <leader>L :Ag<CR>
nmap <leader>fi :lua require('telescope.builtin').live_grep({layout_strategy='horizontal',path_display={"tail"}, layout_config={width=130, preview_width=0.6}})<CR>
nmap <leader>ma :lua require('telescope.builtin').marks({layout_strategy='horizontal',path_display={"tail"}, layout_config={width=130, preview_width=0.6}})<CR>
nmap <leader>gb :Git blame<CR>
nmap <leader><leader>g :Git<CR>
map <leader>V "+y
"xmap <leader>a gaip*
"nmap <leader>a gaip*
nmap <leader>li :Limelight!!<CR>
nmap <leader><leader>b :Buffers<CR>
" nmap <leader><leader>b :lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown({layout_config={width=130}}))<CR>
nmap <leader><leader>a zz
nmap <leader>cm :BCommits<CR>
nmap <leader>dif :SignifyDiff<CR>
nmap <leader>ud :UndotreeToggle<CR>
nnoremap<leader>bd :%bd!<CR>
nmap gs <Plug>(coc-git-chunkinfo)
" nmap \ :EditVifm<CR>
nmap \ :NvimTreeToggle<CR>
" nmap \ :lua require('telescope.builtin').file_browser({layout_strategy='horizontal', layout_config={width=130, preview_width=0.6}})<CR>
nnoremap<Tab> :bnext<CR>
nnoremap<S-Tab> :bprevious<CR>
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <leader>sp :split<CR>
nnoremap <leader>vs :vs<CR>
nnoremap <leader>sw <C-w>r
nnoremap <leader>ee <C-w>=
nnoremap <leader>log :G log<CR>
nnoremap <leader>ga :G add .<CR>
nnoremap <leader>gc :G commit<CR>
nnoremap <leader>amen :G commit --amend --no-edit<CR>
nnoremap <leader>pu :G push -u origin<CR>
nnoremap <leader>chk :G checkout
nnoremap <leader>nb :G checkout -b
nnoremap <leader>br :G branch<CR>
nnoremap <leader>res :G reset --hard
nnoremap <leader>us :G status<CR>
nnoremap <leader>undo :G checkout -- .<CR>
nnoremap <leader>sta :G stash --index<CR>
map <leader>mf :diffget //2<CR>
map <leader>mj :diffget //3<CR>
nnoremap <leader>G :15split \| Gedit :<CR>
nnoremap <leader>j <C-w><C-w>
nnoremap <leader>pre :Prettier<CR>
nnoremap <leader><leader> <C-w>
nnoremap Y y$
nnoremap L 15j
nnoremap H 15k
nnoremap U <C-r>
nnoremap E $
nnoremap B ^
nnoremap <expr> <f9> &foldlevel ? 'zM' :'zR'
nnoremap <f8> zA
nnoremap ff za
tmap <Esc> <C-\><C-n>
tmap <C-w> <Esc><C-w>
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
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
nmap <leader>bb <C-^>
nmap ma 'Azz
nmap 'a mA
nmap ms 'Szz
nmap 's mS
nmap md 'Dzz
nmap 'd mD
nmap mf 'Fzz
nmap 'f mF
nmap ma 'Azz
nmap 'g mG
nmap mg 'Gzz
nmap 'v mV
nmap mb 'Bzz
nmap 'r mR
nmap mr 'Rzz
nmap 't mT
nmap <leader>op :!open %<CR>
nmap <leader>md :!mkdir
nmap <leader>rm :!rm -rf
nmap <leader>fp :let @" = expand("%")<CR>
nmap <leader>pt 1 <C-g>
nmap <leader>ppt :let @" = expand("%")<CR>
nmap <leader>dma :delmarks A-Z0-9<CR>
nmap <leader>rn :Move %
