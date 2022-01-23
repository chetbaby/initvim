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
    use 'machakann/vim-highlightedyank'
    use 'lifepillar/vim-gruvbox8'
    use 'tpope/vim-commentary'
    
    -- SNIPPETS 
    use 'honza/vim-snippets'
    use 'SirVer/ultisnips'

    use 'romainl/vim-cool'
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use 'mizlan/termbufm'
    use 'nvim-treesitter/nvim-treesitter'
    -- use 'neovim/nvim-lspconfig'
    -- use 'nvim-lua/completion-nvim'
    -- use 'nvim-lua/diagnostic-nvim'
    use 'tweekmonster/startuptime.vim'
    use 'wbthomason/packer.nvim'
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'ryanoasis/vim-devicons'
    use 'junegunn/goyo.vim' -- zen mode
    -- use 'junegunn/limelight.vim'
    use 'luochen1990/rainbow'
    -- Color Schemes
    use 'morhetz/gruvbox'
    -- Functionalities
    -- use 'vifm/vifm.vim'
    use {'neoclide/coc.nvim', branch = 'release'}
    use 'vim-scripts/restore_view.vim'
    use 'tpope/vim-fugitive'
    use 'tommcdo/vim-fugitive-blame-ext'
    use 'mhinz/vim-signify'
    use 'tpope/vim-sensible'
    use 'tpope/vim-surround'
    -- use 'mbbill/undotree'
    use 'alvan/vim-closetag'
    use 'AndrewRadev/tagalong.vim'
    -- use 'Valloric/MatchTagAlways'
    use 'qpkorr/vim-bufkill'
    -- nw Plug 'metakirby5/codi.vim'
    use 'jiangmiao/auto-pairs'
    -- use 'junegunn/vim-easy-align'
    use 'Yggdroot/indentLine'
    use 'sheerun/vim-polyglot'
    use 'norcalli/nvim-colorizer.lua'
    -- use 'dkarter/bullets.vim'
     -- use 'psliwka/vim-smoothie'
    use 'jparise/vim-graphql'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'tpope/vim-eunuch'
    use 'mhinz/vim-startify'
    use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require'nvim-tree'.setup {} end
    }
    use 'LionC/nest.nvim'
  end
)
