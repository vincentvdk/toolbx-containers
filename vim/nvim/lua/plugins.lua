-- Neovim Plugins using Packer
--
-- ## usefull info
-- Print 'packpath' -> run :lua print(vim.o.packpath)

-- Set Packer path
local packer_path = vim.fn.stdpath('config') .. '/site'
vim.o.packpath = vim.o.packpath .. ',' .. packer_path

-- Plugin install
return require('packer').startup(function(use)
  use "wbthomason/packer.nvim"
  -- Plugins here
  
  -- Theme
  use "EdenEast/nightfox.nvim"
  
  -- Status line
  use "nvim-lualine/lualine.nvim"

  -- LSP
  use ({"neovim/nvim-lspconfig"})     -- enable LSP
  use ({"hrsh7th/nvim-cmp"})          -- Autocompletion plugin
  use ({"hrsh7th/cmp-nvim-lsp"})      -- LSP source for nvim-cmp
  use ({"L3MON4D3/LuaSnip"})          -- nvim-cmp needs a snippet engine
  use ({"saadparwaiz1/cmp_luasnip"})  -- nvim-cmp needs a snippet engine (dep)

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim", tag = '0.1.0',
    requires = { {"nvim-lua/plenary.nvim"} }
  }
end)
