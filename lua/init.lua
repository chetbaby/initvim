vim.opt.termguicolors = true
require('colorscheme')
require('pre-plugin')
require('plugins')
require('settings')
vim.g.UltiSnipsExpandTrigger="<tab>"
vim.g.UltiSnipsJumpForwardTrigger="<c-b>"
vim.g.UltiSnipsJumpBackwardTrigger="<c-z>"
require'colorizer'.setup() -- here because it's after termguicolors
