-- Global config
vim.g.mapleader = ','
vim.o.encoding = "utf8"
vim.o.modelines = 1
vim.o.cmdheight = 2
vim.o.ruler = true
vim.o.swapfile = false
vim.o.cursorline = true   -- highlight current line
vim.o.wrap = false        -- wrap long lines
vim.o.autoindent = true   -- indentation
vim.o.smartindent = true  -- indentation
vim.o.scrolloff = 10      -- keep cursor x lines from bottom when scrolling 
vim.o.showmatch = false   -- [{}] matching already part of color theme?
vim.o.autoindent = true   -- indentation
vim.o.smartindent = true  -- indentation

-- Mapping and keys -- https://github.com/nanotee/nvim-lua-guide#defining-mappings
vim.keymap.set('n', ';', ':', {desc = 'use : without SHIFT'})
vim.keymap.set('n', ':', ';', {desc = 'use : without SHIFT'})
vim.keymap.set('n', 'jk', '<Esc>', {desc = 'use jk as Escape alternative'})
vim.keymap.set('i', 'jk', '<Esc>', {desc = 'use jk as Escape alternative (inoremap)'})
vim.keymap.set('x', 'jk', '<Esc>', {desc = 'use jk as Escape alternative (xnoremap)'})
vim.keymap.set('c', 'jk', '<Esc>', {desc = 'use jk as Escape alternative (cnoremap)'})
--vim.keymap.set('i', '<S-Enter>', '<Esc>o', {desc = 'new line in insert mode | Shift-Enter -> o'})
vim.keymap.set('n', '<silent>', '<Space>', {desc = 'new line in insert mode | Shift-Enter -> o'})
vim.keymap.set('n', '<C-p>', ':Telescope find_files<cr>', {desc = 'Telescope - CTRL-p to open files'})
-- TODO buffer stuff could move to telescope
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', {desc = 'BUFFERS - switch to next buffer'})
vim.keymap.set('n', '<leader>bb', ':bprevious<CR>', {desc = 'BUFFERS - switch to previous buffer'})
-- https://vim.fandom.com/wiki/Deleting_a_buffer_without_closing_the_window
vim.keymap.set('n', '<leader>bq', ':bp <BAR> bd#<CR>', {desc = 'BUFFERS -  Close the current buffer and move to the previous one'})
vim.keymap.set('n', '<leader>bl', ':ls', {desc = 'BUFFERS - list all open buffers'})


-- Buffer config
vim.bo.swapfile = false
 
-- Clipboard
vim.o.clipboard = "unnamedplus"
--vim.o.clipboard = {
--  copy = {
--    ['+'] = { 'copyq', 'add', '-' },
--    ['*'] = { 'copyq', 'add', '-' },
--  },
--  paste = {
--    ['+'] = { 'copyq', 'paste', '-' },
--    ['*'] = { 'copyq', 'paste', '-' }
--  },
--}

-- Tab behavior
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Line numbers
vim.opt.number = true
--vim.wo.relativenumber = true
vim.api.nvim_command([[
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
]])

-- colors and theme -----------------------------------------------------------
vim.o.termguicolors = true

-- Nightfox theme options (:help nightfox)
require('nightfox').setup({
  options = {
    styles = {
      comments = "italic",
      keywords = "bold",
      functions = "italic,bold",
    },
    inverse = {
      match_paren = true, -- inverse the highlighting of match_paren
    },
    hlgroups = {
      goOperator = { fg = "${yellow_dm}" },
    }
  }
})

-- Load theme (needs to load after settings)
vim.cmd("colorscheme nightfox")   -- https://github.com/EdenEast/nightfox.nvim

-- Lualine --------------------------------------------------------------------
require('lualine').setup()

-- LSP ------------------------------------------------------------------------
-- Autocompletion configuration (hrsh7th/cmp-nvim-lsp)
local cmp = require 'cmp'

cmp.setup {
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  --formatting = {
  --  format = lspkind.cmp_format {
  --    with_text = true,
  --    menu = {
  --      buffer   = "[buf]",
  --      nvim_lsp = "[LSP]",
  --      path     = "[path]",
  --    },
  --  },
  --},
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  })
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Language servers
require('lspconfig')['gopls'].setup{
  capabilities = capabilities
}

require'lspconfig'.tsserver.setup{
  capabilities = capabilities
}
