vim.cmd('packadd packer.nvim')

return require('packer').startup(
  function()
    use '9mm/vim-closer'
    use 'machakann/vim-highlightedyank'
    use 'machakann/vim-sandwich'
    use 'lifepillar/vim-gruvbox8'
    use 'tpope/vim-commentary'
    use 'honza/vim-snippets'
    use 'SirVer/ultisnips'
    use 'romainl/vim-cool'
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use 'mizlan/termbufm'
    -- use 'nvim-treesitter/nvim-treesitter'
    -- use 'neovim/nvim-lspconfig'
    -- use 'nvim-lua/completion-nvim'
    -- use 'nvim-lua/diagnostic-nvim'
    use 'tweekmonster/startuptime.vim'
    use 'wbthomason/packer.nvim'
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'ryanoasis/vim-devicons'
    use 'junegunn/goyo.vim'
    use 'junegunn/limelight.vim'
    use 'luochen1990/rainbow'
    -- Color Schemes
    use 'morhetz/gruvbox'
    -- Functionalities
    use 'vifm/vifm.vim'
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
    -- use {'junegunn/fzf', 'dir': '~/.fzf', 'do': './install --all' }
    -- use 'junegunn/fzf.vim'
    use 'sheerun/vim-polyglot'
    -- use 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
    use 'norcalli/nvim-colorizer.lua'
    use 'heavenshell/vim-pydocstring'
    -- use 'dkarter/bullets.vim'
     -- use 'psliwka/vim-smoothie'
    use 'jparise/vim-graphql'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    -- use {'nvim-treesitter/nvim-treesitter', 'do': ':TSUpdate'} -- We recommend updating the parsers on update
    use 'tpope/vim-eunuch'
    use 'mhinz/vim-startify'
    use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require'nvim-tree'.setup {} end
}
  end
)
