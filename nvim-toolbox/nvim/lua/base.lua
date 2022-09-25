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
-- buffer stuff
vim.keymap.set('n', '<C-b>', ':Telescope buffers<cr>', {desc = 'Telescope - CTRL-b to open buffers'})
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', {desc = 'BUFFERS - switch to next buffer'})
vim.keymap.set('n', '<leader>bb', ':bprevious<CR>', {desc = 'BUFFERS - switch to previous buffer'})
-- https://vim.fandom.com/wiki/Deleting_a_buffer_without_closing_the_window
vim.keymap.set('n', '<leader>bd', ':bp <BAR> bd#<CR>', {desc = 'BUFFERS -  Close the current buffer and move to the previous one'})
vim.keymap.set('n', '<leader>bl', ':ls', {desc = 'BUFFERS - list all open buffers'})
vim.keymap.set('n', '<SPACE>', ':nohl', {desc = 'remove highlights'})

-- Buffer config
vim.bo.swapfile = false
 
-- Clipboard
vim.o.clipboard = "unnamedplus"

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

-- Treesitter -----------------------------------------------------------------
require('nvim-treesitter.configs').setup {
  highlight = { enable = true },
  indent = { enable = true },
}

-- LSP ------------------------------------------------------------------------
-- Diagnostics
local on_attach = function(client, bufnr)
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc') -- Enable completion triggered by <c-x><c-o>
end

-- Autocompletion configuration (hrsh7th/cmp-nvim-lsp)
-- https://github.com/hrsh7th/nvim-cmp/blob/main/doc/cmp.txt
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
  sources = cmp.config.sources({
    { name = 'nvim_lsp', group_index = 1 },
    { name = 'buffer', keyword_length = 4, group_index = 2 },
  }),
  formatting = {
    format = function(entry, vim_item)
      local menu_source = {
        nvim_lsp = '[LSP]',
        buffer = '[BUF]',
      }
      vim_item.menu = menu_source[entry.source.name]
      return vim_item
    end,
  },
}

-- Autocomplete searches
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  }
})

-- Wire up with LSP
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Language servers config ----------------------------------------------------
-- Golang
require('lspconfig')['gopls'].setup{
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
  init_options = {
    usePlaceholders = true,
  }
}

-- Typescript
require'lspconfig'.tsserver.setup{
  on_attach = on_attach,
  capabilities = capabilities
}

-- bashls
require 'lspconfig'.bashls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'zsh', 'bash', 'sh' },
}

---- terraform
require'lspconfig'.tflint.setup{
  on_attach = on_attach,
  capabilities = capabilities
}
require'lspconfig'.terraformls.setup{
  cmd = {"/home/vincent/.asdf/shims/terraform-ls", "serve"},
  on_attach = on_attach,
  capabilities = capabilities
}
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.tf", "*.tfvars"},
  callback = vim.lsp.buf.formatting_sync,
})
