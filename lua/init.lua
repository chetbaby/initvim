vim.opt.termguicolors = true
require('colorscheme')
require('pre-plugin')
require('plugins')
require('settings')
require('keymaps')

require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",
  sync_install = false,
  indent = {
    enable = true,
  },
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}


vim.g.UltiSnipsExpandTrigger="<tab>"
vim.g.UltiSnipsJumpForwardTrigger="<c-b>"
vim.g.UltiSnipsJumpBackwardTrigger="<c-z>"
require('colorizer').setup() -- because it's after termguicolors
