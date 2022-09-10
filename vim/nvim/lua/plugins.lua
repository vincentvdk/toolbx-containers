-- Neovim Plugins using Packer
--
-- ## usefull info
-- Print 'packpath' -> run :lua print(vim.o.packpath)
--

local packer_path = vim.fn.stdpath('config') .. '/site'
vim.o.packpath = vim.o.packpath .. ',' .. packer_path

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- Plugins here
  use "EdenEast/nightfox.nvim"
  use "nvim-lualine/lualine.nvim"
end)
