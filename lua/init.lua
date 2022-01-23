vim.opt.termguicolors = true
require('colorscheme')
require('pre-plugin')
require('plugins')
require('settings')
require('keymaps')
vim.g.UltiSnipsExpandTrigger="<tab>"
vim.g.UltiSnipsJumpForwardTrigger="<c-b>"
vim.g.UltiSnipsJumpBackwardTrigger="<c-z>"
require('colorizer').setup() -- because it's after termguicolors
