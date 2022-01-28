vim.cmd('packadd packer.nvim')

-- PROTECTED CALL
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end
-- RELOAD WHENEVER plugins.lua IS SAVED
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]
-- PACKER POPUP WINDOW
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(
  function()
    use 'wbthomason/packer.nvim'

    -- COLOR SCHEMES
    use 'lifepillar/vim-gruvbox8'
    use 'morhetz/gruvbox'

    -- SNIPPETS
    use 'honza/vim-snippets'
    use 'SirVer/ultisnips'

    -- GIT
    use 'tpope/vim-fugitive'
    use 'tommcdo/vim-fugitive-blame-ext'
    use 'mhinz/vim-signify'

    -- STATUS LINE/STARTUP
    use 'tweekmonster/startuptime.vim'
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'ryanoasis/vim-devicons'

    -- NVIM-TREE
    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icon
      },
      config = function() require'nvim-tree'.setup {} end
    }

    -- FUNCTIONALITIES
    use 'machakann/vim-highlightedyank'
    use 'tpope/vim-commentary'
    use 'mhinz/vim-startify'
    use 'tpope/vim-eunuch'
    use 'vim-scripts/restore_view.vim'
    use 'qpkorr/vim-bufkill'
    use 'Yggdroot/indentLine'
    use 'norcalli/nvim-colorizer.lua'
    use 'voldikss/vim-floaterm'
    --
    -- TAG, PAIRS
    use 'alvan/vim-closetag'
    use 'AndrewRadev/tagalong.vim'
    use 'jiangmiao/auto-pairs'
    use 'tpope/vim-surround'
    use 'Valloric/MatchTagAlways'
    use 'luochen1990/rainbow'

    -- TELESCOPE
    use 'nvim-telescope/telescope.nvim'
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    -- use 'LionC/nest.nvim'

    -- LSP
    use 'nvim-lua/plenary.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-cmdline' }
    use { 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use 'jparise/vim-graphql'
    -- use 'nvim-lua/completion-nvim'
  end
)
