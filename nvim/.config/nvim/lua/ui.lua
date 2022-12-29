vim.opt.background = "dark"
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.guifont = "Hack Nerd Font:9"
vim.opt.hidden = true
vim.opt.laststatus = 2
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.scrolloff = 10
vim.opt.showcmd = true
vim.opt.signcolumn = "auto:2"
vim.opt.termguicolors = true
vim.opt.wildmenu = true
vim.opt.wrap = false

-- Theme
vim.cmd 'colorscheme sonokai'

-- Custom colors
-- See :h coc-highlight
    --highlight CocErrorLine guibg=#512f31
-- vim.cmd([[
--     highlight CocErrorSign guifg=#d1666a
--     highlight CocErrorVirtualText guifg=#d1666a
--     highlight CocErrorFloat guifg=#d1666a
--     highlight CocInlayHint guifg=#605e79
--     highlight CocFadeOut gui=undercurl
--
--     highlight BufferTabpageFill guibg=red
--     highlight BufferTabpages guibg=red
--     highlight BufferOffset guibg=red
--     highlight BufferCurrent gui=bold guibg=red gui=undercurl
--     highlight BufferInactive guibg=red
--     highlight BufferCurrentSign guibg=red
--     highlight BufferInactiveSign guibg=red
--
-- ]])
