-- Global config
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

-- Remapping and keys -- https://github.com/nanotee/nvim-lua-guide#defining-mappings
vim.keymap.set('n', ';', ':', {desc = 'use : without SHIFT'})
vim.keymap.set('n', ':', ';', {desc = 'use : without SHIFT'})
vim.keymap.set('n', 'jk', '<Esc>', {desc = 'use jk as Escape alternative'})
vim.keymap.set('i', 'jk', '<Esc>', {desc = 'use jk as Escape alternative (inoremap)'})
vim.keymap.set('x', 'jk', '<Esc>', {desc = 'use jk as Escape alternative (xnoremap)'})
vim.keymap.set('c', 'jk', '<Esc>', {desc = 'use jk as Escape alternative (cnoremap)'})
--vim.keymap.set('i', '<S-Enter>', '<Esc>o', {noremap = false, desc = 'new line in inser mode | Shift-Enter -> o'})

-- Buffer config
vim.bo.swapfile = false

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


