-- Leader mappings
local whichkey = require("which-key")
local telescope = require("telescope.builtin")

local mappings = {
    f = {
        name = "Find",
        f = { telescope.find_files, "Find file" },
        r = { telescope.oldfiles, "Find recent file" },
        b = { telescope.buffers, "Find file in buffers" },
        g = { telescope.live_grep, "Search expression in documents" },
        w = { telescope.buffers, "Search word under cursor" },
    },

    g = {
        name = "Git",
        s = { 
            name = "Git status",
            s = { telescope.git_status, "Git status (simplified)" },
            e = { "<Cmd>Git<CR>", "Git status (extended)" },
        },
        d = { "<Cmd>Gvdiffsplit<CR>", "Git diff" },
        h = { "<Cmd>0Gllog<CR>", "Git history" },
        ["["] = { "<Plug>(GitGutterPrevHunk)", "Previous git hunk" },
        ["]"] = { "<Plug>(GitGutterNextHunk)", "Next git hunk" },
    },

    e = { "<Cmd>lua require('nvim-tree.api').tree.toggle({find_file=true, focus=true, update_root=true})<CR>", "Explore Files" },

    r = {
        name = "Run",
        r = { ":VimuxRunLastCommand<CR>", "Run last command" },
        p = { ":VimuxPromptCommand<CR>", "Run a command" },
    },

    t = {
        name = "Test",
        t = { "<Cmd>lua require('neotest').run.run_last()<CR>", "Run last test" },
        h = { "<Cmd>lua require('neotest').run.run({strategy='integrated'})<CR>", "Run nearest test" },
        d = { "<Cmd>lua require('neotest').run.run({strategy='dap'})<CR>", "Run nearest test in debugger" },
        f = { "<Cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", "Run tests in file" },
        s = { "<Cmd>lua require('neotest').summary.toggle()<CR>", "Show/hide summary panel" },
        o = { "<Cmd>lua require('neotest').output_panel.toggle()<CR>", "Show/hide output panel" },
    },

    d = {
        name = "Debug",
        u = { "<Cmd>lua require('dapui').toggle()<CR>", "Show/hide debugger" },
        b = { "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", "Enable/disable breakpoint" },
        d = { "<Cmd>lua require'dap'.continue()<CR>", "Launch debug session" },
        c = { "<Cmd>lua require'dap'.run_to_cursor()<CR>", "Continue until cursor position" },
        t = { "<Cmd>lua require'dap'.terminate()<CR>", "Terminate debug session" },
        i = { "<Cmd>lua require'dap'.repl.toggle()<CR>", "Show/hide REPL panel" },
        s = { "<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", "Show diagnostics of current line" },

    },

    c = { 
        name = "Code",
        -- c = { "<Cmd>CommentToggle<CR>", "Comment/uncomment selection" },
        d = { "<Plug>(coc-definition)", "Jump to definition" },
        t = { "<Plug>(coc-type-definition)", "Jump to type definition" },
        i = { "<Plug>(coc-implementation)", "Jump to implementation" },
        r = { "<Plug>(coc-references)", "Show references" },
        s = { "<Cmd>CocCommand pyright.organizeimports<CR>", "Sort imports" },
        ["["] = { "<Plug>(coc-diagnostic-prev)", "Previous diagnostic" },
        ["]"] = { "<Plug>(coc-diagnostic-next)", "Next diagnostic" },
    },

    b = {
        name = "Buffer",
        d = { "<Cmd>bufdo bd<CR>", "Delete all buffers" },
    },

    ["m"] = { ":call InterestingWords('n')<CR>", "Mark word under cursor" },
    ["<Space>"] = { ":call UncolorAllWords()<CR>:nohl<CR>", "Unmark all words" },
    ["n"] = { ":call WordNavigation(1)<CR>", "Next marked word" },
    ["N"] = { ":call WordNavigation(0)<CR>", "Previous marked word" },
    ["w"] = { ":set wrap!<CR>", "Toggle wrapping" },
    ["i"] = { ":IndentBlanklineToggle<CR>", "Toggle visual indentation" },
    ["s"] = { "<Plug>SlimeSendCell", "Send code cell to REPL" },

    ["<Leader>"] = { "<Cmd>WhichKey<CR>", "Show all mappings" },
}
local options = {
    mode = "n", -- Normal mode
    prefix = "<Leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
}

whichkey.register(mappings, options)

-- Non-leader mappings
function map(shortcut, command, description)
    vim.api.nvim_set_keymap("n", shortcut, command, { noremap = true, silent = true, desc = description })
end

-- Increment/decrement next number on line
map("<A-a>", "<C-a>", "Increment next number on line")
map("<A-x>", "<C-x>", "Decrement next number on line")

-- Add line without going to insert mode
map("]<Space>", "o<Esc>", "Add empty line above")
map("[<Space>", "O<Esc>", "Add empty line below")

-- Move across quick-action list
map("<C-A-j>", ":lnext<CR>", "Next item in action panel")
map("<C-A-k>", ":lprev<CR>", "Previous item in action panel")
map("<C-A-c>", ":lclose<CR>", "Close quick-action panel")

-- Buffer and tabs
map("<A-,>", "<Cmd>BufferLineCyclePrev<CR>", "Previous buffer")
map("<A-.>", "<Cmd>BufferLineCycleNext<CR>", "Next buffer")
map("<A-c>", "<Cmd>BufferLinePickClose<CR>", "Close buffer")
map("<A-p>", "<Cmd>BufferLinePick<CR>", "Pick buffer")
map("<A-d>", "<Cmd>:bd<CR>", "Delete buffer")
map("<A-t>", "<Cmd>tabnew<CR>", "New tab")
map("<A-h>", "<Cmd>tabprevious<CR>", "Previous tab")
map("<A-l>", "<Cmd>tabnext<CR>", "Next tab")
map("<A-v>", "<Cmd>vsplit<CR>", "Vertical split")
map("<A-z>", "<Cmd>split<CR>", "Horizontal split")

-- Tmux navigator
map("<C-h>", "<Cmd>TmuxNavigateLeft<CR>", "Navigate left")
map("<C-j>", "<Cmd>TmuxNavigateDown<CR>", "Navigate down")
map("<C-k>", "<Cmd>TmuxNavigateUp<CR>", "Navigate up")
map("<C-l>", "<Cmd>TmuxNavigateRight<CR>", "Navigate right")
map("<C-Bslash>", "<Cmd>TmuxNavigatePrevious<CR>", "Navigate to previous")

-- Markers: lfv89/vim-interestingwords
map("n", ":call WordNavigation(1)<CR>", "Next marked word")
map("N", ":call WordNavigation(0)<CR>", "Previous marked word")

-- Sneaky motion
map("s", "<Plug>Sneak_s", "Jump to next char sequence")
map("S", "<Plug>Sneak_S", "Jump to previous char sequence")
map(";", "<Plug>Sneak_;", "Repeat next character jump")
map(",", "<Plug>Sneak_,", "Repeat previous character jump")

-- Apply macro to visual selection
vim.api.nvim_exec([[
    :xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
    function! ExecuteMacroOverVisualRange()
        echo "@".getcmdline()
        execute ":'<,'>normal @".nr2char(getchar())
    endfunction
    ]], true)
