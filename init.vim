"=========================================================
"===================== PLUGINS ===========================
"=========================================================
call plug#begin()
" Aesthetics - Main
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'luochen1990/rainbow'
" Color Schemes
Plug 'herrbischoff/cobalt2.vim'
Plug 'morhetz/gruvbox'
" Functionalities
Plug 'vifm/vifm.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/restore_view.vim'
Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-fugitive-blame-ext'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
" Plug 'mbbill/undotree'
Plug 'alvan/vim-closetag'
Plug 'AndrewRadev/tagalong.vim'
" Plug 'Valloric/MatchTagAlways'
Plug 'qpkorr/vim-bufkill'
" nw Plug 'metakirby5/codi.vim'
Plug 'jiangmiao/auto-pairs'
" Plug 'junegunn/vim-easy-align'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
" Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'heavenshell/vim-pydocstring'
" Plug 'dkarter/bullets.vim'
 " Plug 'psliwka/vim-smoothie'
Plug 'jparise/vim-graphql'
call plug#end()

"===================================================
"==================   LANGUAGE SETUP ===============
"===================================================
" let g:python3_host_prog = '/usr/local/bin/python3'
let g:python_host_prog = '/usr/bin/python2.7'
let g:node_host_prog = '/usr/local/lib/node_modules/neovim/bin/cli.js'
let g:loaded_ruby_provider = 0 "off
let g:node = 0 "off
let g:loaded_python_provider = 0 "off
let g:loaded_perl_provider = 0 "off

" HTML, XML, Jinja, etc.
autocmd FileType python nmap <leader>x :0,$!~/.config/nvim/env/bin/python -m yapf<CR>
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType xml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango inoremap {{ {{  }}<left><left><left>
autocmd FileType htmldjango inoremap {% {%  %}<left><left><left>
autocmd FileType htmldjango inoremap {# {#  #}<left><left><left>
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2

"=======================================
"============   BASE/SANITY ============
"=======================================
syntax on
filetype plugin indent on
set modifiable
set noerrorbells
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab autoindent smartindent
set number relativenumber
set noswapfile nobackup
set incsearch ignorecase smartcase hlsearch
set ruler laststatus=2 showcmd showmode
set list listchars=trail:??,tab:??-
set fillchars+=vert:\
set wrap breakindent
set encoding=utf-8
set background=dark
set title
set foldmethod=indent
set foldnestmax=30
set nofoldenable
set foldlevel=1
set splitbelow splitright
set viewoptions=cursor,folds,slash,unix
set hidden
set cmdheight=2
set updatetime=100
set shortmess+=c
set signcolumn=yes
set autoread
let g:skipview_files = ['*\.vim']

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
"============ DISPLAY PREFERENCES ============
"=============================================
highlight Pmenu guibg=white guifg=black gui=bold
highlight Pmenu guifg=black gui=bold
highlight Comment gui=bold
highlight NonText guibg=none
highlight Normal guibg=NONE ctermbg=NONE
highlight LineNr guibg=NONE ctermbg=NONE
highlight MatchParen guibg=lightyellow
highlight default link CocErrorHighlight   CocUnderline
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:gruvbox_italic=1
colorscheme gruvbox

set termguicolors
set guicursor+=n-v-c:blinkon1
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50

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

" Floating window
function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')
  let height = float2nr(35)
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
nmap <leader>t :call TrimWhitespace()<CR>
nmap <leader>d <Plug>(pydocstring)
nmap <leader>co :Colors<CR>
nmap <leader>f :Files<CR>
nmap <leader>L :Ag<CR>
nmap <leader>gb :Git blame<CR>
nmap <leader><leader>g :Git<CR>
map <leader>V "+y
"xmap <leader>a gaip*
"nmap <leader>a gaip*
nmap <leader>li :Limelight!!<CR>
nmap <leader><leader>b :Buffers<CR>
nmap <leader><leader>a zz
nmap <leader>cm :BCommits<CR>
nmap <leader>dif :SignifyDiff<CR>
nmap <leader>ud :UndotreeToggle<CR>
nnoremap<leader>bd :%bd!<CR>
nmap gs <Plug>(coc-git-chunkinfo)
nmap \ :EditVifm<CR>
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
