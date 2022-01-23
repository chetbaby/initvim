vim.cmd('colorscheme gruvbox')
vim.g['$NVIM_TUI_ENABLE_TRUE_COLOR'] = 1
vim.g.gruvbox_italic = 1
vim.cmd([[
  highlight Pmenu guibg=white guifg=black gui=bold
  highlight Pmenu guifg=black gui=bold
  highlight Comment gui=bold
  highlight NonText guibg=none
  highlight Normal guibg=NONE ctermbg=NONE
  highlight LineNr guibg=NONE ctermbg=NONE
  highlight MatchParen guibg=lightyellow
  highlight default link CocErrorHighlight   CocUnderline
]])
vim.opt.guicursor = vim.opt.guicursor + 'n-v-c:blinkon1'
vim.opt.guicursor = vim.opt.guicursor + 'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50'
