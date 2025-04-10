return {
    -- Note: There is an issue with using TSInstall under alacritty, the `arch` command incorrectly
    -- reports that the architecture is i386 instead of arm64. So it is best to use a different terminal
    -- when installing parsers.
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })()
        end,
        config = function () 
            require("nvim-treesitter.configs").setup {
            highlight = { enable = true },
            indent = { enable = true },  
            }
        end,
    },

    {
        "numToStr/Comment.nvim",
        opts = {
            -- add any options here
        }
    },

    {
        "mg979/vim-visual-multi",
        lazy = false,
    },

    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup {
            -- Configuration here, or leave empty to use defaults
            }
        end
    },

    {
        "SirVer/ultisnips",
        config = function()
            -- Use <C-j> to trigger snippets
            vim.keymap.set("i", "<C-j>", "<Plug>(coc-snippets-expand-jump)", { silent = true, noremap = true, expr = true, desc = "Snippet" })
            -- vim.g.coc_snippet_next = '<c-l>'
            -- vim.g.coc_snippet_prev = '<c-h>'

        end
    },

    {
        "Wansmer/treesj",
        dependencies = { "nvim-treesitter/nvim-treesitter", "neoclide/coc.nvim" }, -- if you install parsers with `nvim-treesitter`
        config = function()
            require("treesj").setup({
                use_default_keymaps = false,
            })
            local wk = require("which-key")
            wk.add( { "<Leader>s", group = "Split", icon = { icon = "󰃻", color = "grey" } } )
            wk.add( { "<Leader>st", "<Cmd>TSJToggle<CR>", desc = "Toggle", icon = { icon = "󰔡", color = "grey" } } )
            wk.add( { "<Leader>ss", "<Cmd>TSJSplit<CR>", desc = "Split", icon = { icon = "󰃻", color = "grey" } } )
            wk.add( { "<Leader>sj", "<Cmd>TSJJoin<CR>", desc = "Join", icon = { icon = "󰽜", color = "grey" } } )
        end,
    },

    {
        "neoclide/coc.nvim",
        branch = "release",
        config = function()
            local keyset = vim.keymap.set
            local wk = require("which-key")
            wk.add( {"<Leader>c", group = "Code", icon = { icon = "", color = "grey" } } )

            -- Autocomplete
            function _G.check_back_space()
                local col = vim.fn.col(".") - 1
                return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
            end

            -- Use Tab for trigger completion with characters ahead and navigate
            -- NOTE: There's always a completion item selected by default, you may want to enable
            -- no select by setting `"suggest.noselect": true` in your configuration file
            -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
            -- other plugins before putting this into your config
            keyset(
            "i",
            "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
            { silent = false, noremap = true, expr = true, replace_keycodes = false, desc = "Next auto-completion item"}
            )
            keyset(
            "i",
            "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]],
            { silent = false, noremap = true, expr = true, replace_keycodes = false, desc = "Next auto-completion item"}
            )

            -- Make <CR> to accept selected completion item or notify coc.nvim to format
            -- <C-g>u breaks current undo, please make your own choice
            keyset("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], { silent = false, noremap = true, expr = true, replace_keycodes = false, desc = "Use auto-completion item"})

            -- Use <C-space> to trigger completion
            keyset("i", "<C-space>", "coc#refresh()", { silent = true, expr = true, desc = "Auto-completion" })

            -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list

            -- Documentation
            function _G.show_docs()
                local cw = vim.fn.expand("<cword>")
                if vim.fn.index({"vim", "help"}, vim.bo.filetype) >= 0 then
                    vim.api.nvim_command("h " .. cw)
                elseif vim.api.nvim_eval("coc#rpc#ready()") then
                    vim.fn.CocActionAsync("doHover")
                else
                    vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
                end
            end
            wk.add( { "<Leader>ck", "<Cmd>lua _G.show_docs()<CR>", desc = "Show documentation", icon = { icon = "", color = "grey" } } )

            -- Highlight the symbol and its references on a CursorHold event (cursor is idle)
            vim.api.nvim_create_augroup("CocGroup", {})
            vim.api.nvim_create_autocmd("CursorHold", {
                group = "CocGroup",
                command = "silent call CocActionAsync('highlight')",
                desc = "Highlight symbol under cursor on CursorHold"
            })

            wk.add( { "<Leader>cc", "<Plug>(coc-definition)", desc = "Definition", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>cd", group = "Diagnostic", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>cdd", "<Cmd>CocDiagnostics<CR>", desc = "Diagnostics", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>cd[", "<Plug>(coc-diagnostic-prev)", desc = "Previous", icon = { icon = "↩️", color = "grey" } } )
            wk.add( { "<Leader>cd]", "<Plug>(coc-diagnostic-next)", desc = "Next", icon = { icon = "↪️", color = "grey" } } )
            wk.add( { "<Leader>ch", "<Cmd>CocCommand document.toggleInlayHint<CR>", desc = "Hints", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>cQ", "<Cmd>CocRestart<CR>", desc = "Quit & restart", icon = { icon = "󰐥", color = "grey" } } )
            -- Disable the inlay hints by default
            -- vim.api.nvim_command("autocmd BufEnter *.cpp silent! CocCommand document.toggleInlayHint")
            -- vim.api.nvim_command("autocmd User CocNvimInit call CocAction('runCommand', 'document.toggleInlayHint')")
            -- vim.api.nvim_command("autocmd FileType cpp autocmd User CocNvimInit call CocAction('runCommand', 'document.toggleInlayHint')")

            -- Using telescope-coc
            wk.add( { "<Leader>cr", "<Cmd>Telescope coc references<CR>", desc = "References", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>cp", "<Cmd>Telescope coc definitions<CR>", desc = "Definition peek", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>ca", group = "Actions", icon = { icon = "⚡", color = "grey" } } )
            wk.add( { "<Leader>cac", "<Cmd>Telescope coc code_actions<CR>", desc = "Code", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>cal", "<Cmd>Telescope coc line_code_actions<CR>", desc = "Line", icon = { icon = "󰸱", color = "grey" } } )
            wk.add( { "<Leader>cad", "<Cmd>Telescope coc file_code_actions<CR>", desc = "Document", icon = { icon = "󱁻", color = "grey" } } )
            wk.add( { "<Leader>caa", "<Cmd>Telescope coc<CR>", desc = "Available...", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>cs", group = "Symbols", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>csd", "<Cmd>Telescope coc document_symbols<CR>", desc = "Document", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>csw", "<Cmd>Telescope coc workspace_symbols<CR>", desc = "Workspace", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>cm", "<Cmd>Telescope coc commands<CR>", desc = "Commands", icon = { icon = "", color = "grey" } } )
        end
    },

    {
        "AndrewRadev/switch.vim",
        config = function()
            vim.g.switch_mapping = ""
            local wk = require("which-key")
            wk.add( { "<Leader>ct", "<Cmd>Switch<CR>", desc = "Toggle value", icon = { icon = "󰓤", color = "grey" } } )
        end
    },

    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        -- event = "InsertEnter",
        event = "VeryLazy",
        config = function()
            require("copilot").setup {
                panel = {
                    enabled = true,
                    auto_refresh = true,
                    keymap = {
                        jump_prev = "<M-[[>",
                        jump_next = "<M-]]>",
                        accept = "<M-l>",
                        refresh = "gr",
                        open = "<M-CR>"
                    },
                    layout = {
                        position = "bottom", -- | top | left | right
                        ratio = 0.2
                    },
                },
                suggestion = {
                    auto_trigger = true,
                },
            }
            require("copilot.suggestion").toggle_auto_trigger()
            local wk = require("which-key")
            wk.add( { "<Leader>cp", "<Cmd>Copilot panel<CR>", desc = "GitHub Copilot", icon = { icon = "", color = "grey" } } )
        end,
    },

    -- {
    --     "zbirenbaum/copilot-cmp",
    --     config = function ()
    --         require("copilot_cmp").setup()
    --     end
    -- },

    { "fannheyward/telescope-coc.nvim" },

    { "tpope/vim-dispatch" },

    {
        "kevinhwang91/nvim-bqf",
        config = function()
            local wk = require("which-key")
            wk.add( { "<Leader>cq", group = "Quickfix", icon = { icon = "", color = "grey" } } )

            local quickfix_toggle = function()
                local qf_exists = false
                for _, win in pairs(vim.fn.getwininfo()) do
                    if win["quickfix"] == 1 then
                        qf_exists = true
                    end
                end
                if qf_exists == true then
                    vim.cmd "cclose"
                    return
                end
                if not vim.tbl_isempty(vim.fn.getqflist()) then
                    vim.cmd "copen 40"
                end
            end
            wk.add( { "<Leader>cqq", quickfix_toggle, desc = "Quickfix", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>cq[", "<Cmd>cprev<CR>", desc = "Previous", icon = { icon = "↩️", color = "grey" } } )
            wk.add( { "<Leader>cq]", "<Cmd>cnext<CR>", desc = "Next", icon = { icon = "↪️", color = "grey" } } )
        end,
    },

    {
        "yorickpeterse/nvim-pqf",
        config = function()
            require('pqf').setup()
        end,
    },

    {
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup()
        end,
    },

}
