-- Leader key
-- vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Tabbing
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Update time
vim.opt.updatetime = 300

-- Clipboard
vim.opt.clipboard = 'unnamedplus'

-- Also match <> with highlights and %-jumps
vim.opt.listchars:append(vim.opt, "<:>")

