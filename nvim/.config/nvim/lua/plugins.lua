ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
    -- Packer
    use "wbthomason/packer.nvim"

    -- Which Key
    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {
                window = {
                    border = "single", -- none, single, double, shadow
                    position = "bottom", -- bottom, top
                },
            }
        end
    }

    -- Lualine
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
            require("lualine").setup {
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = { left = "", right = ""},
                    section_separators = { left = "", right = ""},
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
                    lualine_a = {"mode"},
                    lualine_b = {"branch", "diff", "diagnostics"},
                    lualine_c = {"filename"},
                    lualine_x = {"encoding", "fileformat", "filetype"},
                    lualine_y = {"progress"},
                    lualine_z = {"location"}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {"filename"},
                    lualine_x = {"location"},
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {}
            }
        end
    }

    -- Tabs and buffers
    use {
        "akinsho/bufferline.nvim", 
        tag = "v3.*",
        requires = "nvim-tree/nvim-web-devicons",
        config = function()
            require("bufferline").setup({
                options = {
                    -- separator_style = "padded_slant",
                    diagnostics = "coc",
                    update_focused_file = {
                        enable = true,
                        update_root = true,
                        ignore_list = {},
                    },
                    filters = {
                        dotfiles = false,
                    }
                }
            })
        end
    }

    -- Tmux
    use {
        "christoomey/vim-tmux-navigator",
        config = function()
            vim.g.tmux_navigator_disable_when_zoomed = 1
            vim.g.tmux_navigator_no_mappings = 1
        end
    }
    use "benmills/vimux" 

    -- Two character jump
    use "justinmk/vim-sneak"

    -- Improved word jump, seems to be more of a hassle than it's worth
    -- Especially the change in word and multi-editing is not working well
    -- Would be nice if only the jump feature could be used
    -- use "chaoren/vim-wordmotion"

    -- Multiple cursor editing
    use "mg979/vim-visual-multi"

    -- Change surround
    use {
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
        end
    }

    -- Commenter
    use {
        "terrortylor/nvim-comment",
        config = function()
            require("nvim_comment").setup({
                create_mappings = true,
                -- Normal mode mapping left hand side
                line_mapping = "<Leader>c<Space>",
                -- Visual/Operator mapping left hand side
                operator_mapping = "<Leader>c",
                -- text object mapping, comment chunk
                --comment_chunk_text_object = "<Leader>cci",
            })
        end
    }

    -- Markers
    use {
        "lfv89/vim-interestingwords",
        config = function()
            vim.g.interestingWordsDefaultMappings = 0
            vim.g.interestingWordsGUIColors = {"#FFDB72", "#A4E57E", "#85D3F2", "#FF7272", "#FFB3FF", "#9999FF"}
            vim.g.interestingWordsTermColors = {"100", "121", "211", "137", "214", "222"}
        end
    }

    -- CSS Colorizer
    use {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require"colorizer".setup()
        end
    }

    -- File browsers
    use {
        "nvim-tree/nvim-tree.lua",
        requires = "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-tree").setup({
                sort_by = "case_sensitive",
                actions = {
                    open_file = {
                        quit_on_open = true,
                    },
                },
                filters = {
                    dotfiles = true,
                },
                view = {
                    adaptive_size = true,
                    mappings = {
                        -- See https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt#L1458
                        custom_only = true,
                        list = {
                            { key = "g?", action = "toggle_help" },
                            { key = "dd", action = "remove" },
                            { key = "u", action = "dir_up" },
                            { key = "<A-v>", action = "vsplit" },
                            { key = "<A-z>", action = "split" },
                            { key = "<A-t>", action = "tabnew" },
                            { key = "a", action = "create" },
                            { key = "A", action = "full_rename" },
                            { key = "f", action = "live_filter" },
                            { key = "x", action = "cut" },
                            { key = "y", action = "copy" },
                            { key = "p", action = "paste" },
                            { key = "o", action = "system_open" },
                            { key = "K", action = "toggle_file_info" },
                            { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
                            { key = "za", action = "toggle_dotfiles" },
                        },
                    },
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = true,
                },
            })
        end
    }

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        requires = { {"nvim-lua/plenary.nvim", "BurntSushi/ripgrep", "nvim-telescope/telescope-fzf-native.nvim"} }
    }

    -- Git
    -- Jump to next/previous chunk with ]c [c
    use {
        "airblade/vim-gitgutter",
        config = function()
            vim.g.gitgutter_map_keys = 0
        end
    }
    use "tpope/vim-fugitive"

    -- Coding
    -- Coc
    -- See https://github.com/neoclide/coc.nvim
    use {
        "neoclide/coc.nvim",
        branch = "release",
        config = function()
            local keyset = vim.keymap.set
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

            -- Use <C-j> to trigger snippets
            -- keyset("i", "<C-j>", "<Plug>(coc-snippets-expand-jump)")
            -- Use <C-space> to trigger completion
            keyset("i", "<C-space>", "coc#refresh()", { silent = true, expr = true, desc = "Trigger auto-completion" })

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
            keyset("n", "<Leader>ck", "<Cmd>lua _G.show_docs()<CR>", { silent = true, desc = "Show documentation" })

            -- Highlight the symbol and its references on a CursorHold event (cursor is idle)
            vim.api.nvim_create_augroup("CocGroup", {})
            vim.api.nvim_create_autocmd("CursorHold", {
                group = "CocGroup",
                command = "silent call CocActionAsync('highlight')",
                desc = "Highlight symbol under cursor on CursorHold"
            })
        end
    }
    use {
        "fannheyward/coc-marketplace",
        requires = "neoclide/coc.nvim"
    }
    use {
        "fannheyward/coc-pyright",
        requires = "neoclide/coc.nvim"
    }
    -- use {
    --     "neoclide/coc-prettier",
    --     requires = "neoclide/coc.nvim"
    -- }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "python", "cmake", "c", "cpp" },
                sync_install = true,
            })
        end
    }

    -- Debugging
    use "mfussenegger/nvim-dap"
    use {
        "mfussenegger/nvim-dap-python",
        config = function()
            require("dap").set_log_level("TRACE")
            require("dap-python").setup()
        end
    }
    use {
        "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" },
        config = function()
            local dap, dapui =require("dap"),require("dapui")
            dapui.setup()
            -- Automatically open/close UI when a session is created/terminated
            dap.listeners.after.event_initialized["dapui_config"]=function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"]=function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"]=function()
                dapui.close()
            end
        end
    }
    use {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup {
                enabled = true,                        -- enable this plugin (the default)
                enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
                highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
                highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
                show_stop_reason = true,               -- show stop reason when stopped for exceptions
                commented = false,                     -- prefix virtual text with comment string
                only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
                all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
                --- A callback that determines how a variable is displayed or whether it should be omitted
                --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
                --- @param buf number
                --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
                --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
                --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
                display_callback = function(variable, _buf, _stackframe, _node)
                return variable.name .. " = " .. variable.value
                end,

                -- experimental features:
                virt_text_pos = "right_align",                 -- position of virtual text, see `:h nvim_buf_set_extmark()`
                all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
                virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
                virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
                                                       -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
            }
        end
    }

    -- Testing
    use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim"
        },
        config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    dap = { justMyCode = true },
                    args = {"--log-level", "DEBUG"},
                    runner = "unittest",
                    python = "./.venv/bin/python"
                }),
            },
          })
        end
    }
    use {
        "nvim-neotest/neotest-python",
        requires="nvim-neotest/neotest"
    }

    -- Repl
    use {
        "jpalardy/vim-slime",
        config = function()
            vim.g.slime_target = "tmux"
            vim.cmd 'let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.1"}'
        end
    }
   
    -- Theme
    use "sainnhe/sonokai"

    -- Auto compile on save
    vim.cmd([[
        augroup packer_user_config
            autocmd!
            autocmd BufWritePost plugins.lua source <afile> | PackerCompile
        augroup end
    ]])
    
    if packer_bootstrap then
        require("packer").sync()
    end
end)


