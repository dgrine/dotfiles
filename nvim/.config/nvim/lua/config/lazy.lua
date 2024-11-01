-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Disable interesting words mappings
vim.g.interestingWordsDefaultMappings = 0

-- Terminal color
vim.opt.termguicolors = true

-- Tabbing
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Numbering
vim.opt.number = true

-- Timing
-- vim.opt.timeout = true
-- vim.opt.timeoutlen = 300
vim.opt.updatetime = 300

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Also match <> with highlights and %-jumps
vim.opt.listchars:append(vim.opt, "<:>")

-- Unix line endings
vim.opt.ff = "unix"

-- Non-leader mappings
    -- Apply macro to visual selection
vim.api.nvim_exec([[
    :xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
    function! ExecuteMacroOverVisualRange()
        echo "@".getcmdline()
        execute ":'<,'>normal @".nr2char(getchar())
    endfunction
    ]], true)
function map(shortcut, command, description)
    vim.api.nvim_set_keymap("n", shortcut, command, { noremap = true, silent = true, desc = description })
end

-- Increment/decrement next number on line
map("<A-a>", "<C-a>", "Increment next number on line")
map("<A-x>", "<C-x>", "Decrement next number on line")

-- Add line without going to insert mode
map("]<Space>", "o<Esc>", "Add empty line above")
map("[<Space>", "O<Esc>", "Add empty line below")

vim.cmd "verbose imap <tab>"

-- Commenting
vim.keymap.set( {"n", "v"}, "<Leader>c<Space>", "gc", { remap = true, desc = "Comment" } )
vim.keymap.set( {"n"}, "<Leader>c<Space>", "gcc", { remap = true, desc = "Comment" } )  -- Use with leader n to comment n lines

-- Ultisnips
vim.g.UltiSnipsExpandTrigger="<c-j>"
vim.g.UltiSnipsJumpForwardTrigger="<c-l>"
vim.g.UltiSnipsJumpBackwardTrigger="<c-h>"
vim.g.UltiSnipsSnippetDirectories={"~/.config/nvim/UltiSnips"}

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "sonokai" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})	
	
