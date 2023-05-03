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
vim.keymap.set('n', '<SPACE>', ':nohl<CR>', {desc = 'remove highlights'})
-- Keep paste data in buffer when replacing (original string stays in buffer)
vim.keymap.set('x', '<leader>p', "\"_dP")
-- Need to check these
vim.keymap.set('n', '<leader>p', "\"_d")
vim.keymap.set('v', '<leader>p', "\"_d")

-- Handling brackets
-- vim.keymap.set('i', '(', '()<left>', { noremap = true })
vim.keymap.set('i', '(', '()<left>', { noremap = true })
vim.keymap.set('i', '{', '{}<left>', { noremap = true })
vim.keymap.set('i', '{<CR>', '{<CR>}<ESC>O', { noremap = true })

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
vim.cmd([[
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
      match_paren = false, -- inverse the highlighting of match_paren
    },
    hlgroups = {
      goOperator = { fg = "${yellow_dm}" },
    }
  }
})

-- Telescope ------------------------------------------------------------------
require('telescope').setup({
  pickers = {
    find_files = {
      find_command = {"rg", "--files", "--hidden", "--glob", "!**/.git/*"}
    }
  }

})

-- Load theme (needs to load after settings)
vim.cmd("colorscheme nightfox")   -- https://github.com/EdenEast/nightfox.nvim

-- highlights -----------------------------------------------------------------
-- EXAMPLE
-- vim.api.nvim_set_hl(0, '@text.note', { link = 'Todo' })
--vim.api.nvim_set_hl(0, '@text.note', {})
-- vim.api.nvim_set_hl(0, 'ToDo', {bg="blue"})
-- vim.cmd[[ match ToDo 'TODO' ]]
-- END EXAMPLE
-- Mark unnecessay whitespace
vim.api.nvim_set_hl(0, 'Whitespace', { bg='Red' })
vim.cmd[[ match Whitespace /\s\+\%#\@<!$/ ]]

-- Lualine --------------------------------------------------------------------
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {{'filename', path=1}},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
--  sections = {
--    lualine_c = {
--      'filename',
--      path = 1,
--    }
--  }
}

-- Treesitter -----------------------------------------------------------------
require('nvim-treesitter.configs').setup {
  highlight = { enable = true },
  indent = { enable = true },
  ensure_installed = { "lua", "go", "dockerfile", "yaml", "comment" },
}

-- LSP ------------------------------------------------------------------------
vim.lsp.set_log_level('off')
-- Diagnostics
-- See `:help vim.lsp.*` for documentation
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc') -- Enable completion triggered by <c-x><c-o>

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<C-o>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
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
    ['<CR>'] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,
      ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end
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
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Language servers config ----------------------------------------------------
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
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
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.go"},
  callback = vim.lsp.buf.formatting_sync,
})

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
