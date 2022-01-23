vim.g.python3_host_prog = '/usr/local/bin/python3'
vim.g.python_host_prog = '/usr/bin/python2.7'
-- vim.g.node_host_prog = '/usr/local/lib/node_modules/neovim/bin/cli.js'
vim.g.loaded_ruby_provider = 0
vim.g.node = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_perl_provider = 0

local options = {
  modifiable = true,
  errorbells = false,
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  smarttab = true,
  autoindent = true,
  smartindent = true,
  number = true,
  relativenumber = true,
  swapfile = false,
  backup = false,
  incsearch = true,
  ignorecase = true,
  smartcase = true,
  hlsearch = true,
  ruler = true,
  laststatus = 2,
  showcmd = true,
  showmode = true,
  list = true, 
  listchars = { tab = '>»', trail = '»' },
  wrap = true,
  breakindent = true,
  encoding = 'utf-8',
  background = 'dark',
  title = true,
  foldmethod = 'indent',
  foldnestmax = 30,
  foldenable = true,
  foldlevel = 1,
  splitbelow = true,
  splitright = true,
  viewoptions = 'cursor,folds,slash',
  hidden = true,
  cmdheight = 2,
  updatetime = 100,
  signcolumn = 'yes',
  autoread = true,
  scrolloff = 12,
  clipboard = 'unnamedplus',
  completeopt = {'menuone', 'noselect'},
  conceallevel = 0,
  mouse = 'a',
  pumheight = 10,
  showtabline = 2,
  termguicolors = true,
  undofile = true,
  guifont = "monospace:h17",
}

vim.opt.shortmess:append "c"
vim.opt.fillchars:append "vert:\\"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
