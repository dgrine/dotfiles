return {

    {
        "folke/which-key.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", "echasnovski/mini.icons" },
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            -- {
            --   "<leader>?",
            --   function()
            --     require("which-key").show({ global = false })
            --   end,
            --   desc = "Buffer Local Keymaps (which-key)",
            -- },
        },
    },

    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
        config = function()
            vim.g.tmux_navigator_disable_when_zoomed = 1
            vim.g.tmux_navigator_no_mappings = 1
        end,
    },

    {
        "benmills/vimux",
        lazy = false,
        config = function()
            local wk = require("which-key")
            wk.add( { "<Leader>r", group = "Run", icon = { icon = "󰜎", color = "grey" } } )
            wk.add( { "<Leader>rr", ":VimuxRunLastCommand<CR>", desc = "Last command" } )
            wk.add( { "<Leader>rp", ":VimuxPromptCommand<CR>", desc = "Any command" } )
        end,
    },

    {
        "jpalardy/vim-slime",
        config = function()
            vim.g.slime_target = "tmux"
            vim.cmd 'let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.1"}'
            vim.cmd 'let g:slime_cell_delimiter = "#%%"'
        end
    },

    {
        "nvim-tree/nvim-tree.lua",
        dependency = "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-tree").setup({
                sort_by = "case_sensitive",
                view = {
                    width = 60,
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = true,
                },
            })
            local wk = require("which-key")
            wk.add( { "<leader>e", function() require("nvim-tree.api").tree.toggle({find_file=true, focus=true, update_root=true}) end, desc = "Navigator", mode = "n", icon = { icon = "", color = "grey" } } )
        end,
    },

    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            modes = {
                search = {
                    enabled = true,
                },
            },
        },
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash forward search" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").jump({ search = { forward = false, wrap = false, multi_window = false } }) end, desc = "Flash backward search" },
            -- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },

    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        lazy = false,
        config = function()
            require("bufferline").setup {
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
                    },
                }
            }
            local wk = require("which-key")
            wk.add( { "<Leader>b", group = "Buffer", icon = { icon = "🅱", color = "grey" } } )
            wk.add( { "<Leader>b]", "<Cmd>:BufferLineCycleNext<CR>", desc = "Next", icon = { icon = "↩️", color = "grey" } } )
            wk.add( { "<Leader>b[", "<Cmd>:BufferLineCyclePrev<CR>", desc = "Previous", icon = { icon = "↪️", color = "grey" } } )
            wk.add( { "<Leader>bb", "<Cmd>:BufferLinePick<CR>", desc = "Pick", icon = { icon = "󰉻", color = "grey" } } )
            wk.add( { "<Leader>bc", "<Cmd>:BufferLinePickClose<CR>", desc = "Close", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>bd", "<Cmd>:bd<CR>", desc = "Delete", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>bs", group = "Split", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>bsv", "<Cmd>vsplit<CR>", desc = "Vertical", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>bsh", "<Cmd>split<CR>", desc = "Horizontal", icon = { icon = "", color = "grey" } } )
        end,
    },

    { 
        "lfv89/vim-interestingwords",
        config = function()
            vim.g.interestingWordsDefaultMappings = 0
            local wk = require("which-key")
            wk.add( { "<Leader>m", group = "Mark", icon = { icon = "󰙒", color = "grey" } } )
            wk.add( { "<Leader>mm", "<Cmd>call InterestingWords('n')<CR>", desc = "Mark", icon = { icon = "󰙒", color = "grey" } } )
            wk.add( { "<Leader>m]", "<Cmd>call WordNavigation(1)<CR>", desc = "Next", icon = { icon = "↪", color = "grey" } } )
            wk.add( { "<Leader>m[", "<Cmd>call WordNavigation(0)<CR>", desc = "Previous", icon = { icon = "󱞥", color = "grey" } } )
            wk.add( { "<Leader>m<Space>", "<Cmd>call UncolorAllWords()<CR>:nohl<CR>", desc = "Clear", icon = { icon = "", color = "grey" } } )
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "BurntSushi/ripgrep",
            "nvim-telescope/telescope-fzf-native.nvim",
        },
        config = function()
            require("telescope").setup({
              extensions = {
                coc = {
                    theme = "ivy",
                    prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
                    push_cursor_on_edit = true, -- save the cursor position to jump back in the future
                    timeout = 3000, -- timeout for coc commands
                }
              },
            })

            local telescope = require("telescope.builtin")
            local wk = require("which-key")
            wk.add( { "<Leader>f", group = "Find", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>ff", telescope.find_files, desc = "Any file", icon = { icon = "󰈞", color = "grey" } } )
            wk.add( { "<Leader>fr", telescope.oldfiles, desc = "Recent file", icon = { icon = "󰷊", color = "grey" } } )
            wk.add( { "<Leader>fb", telescope.buffers, desc = "Loaded file", icon = { icon = "󰮗", color = "grey" } } )
            wk.add( { "<Leader>fg", telescope.live_grep, desc = "Any expression", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>fw", telescope.buffers, desc = "Selected expression", icon = { icon = "󰬶", color = "grey" } } )
            wk.add( { "<Leader>z", "<Cmd>Lazy<CR>", desc = "Plugins", icon = { icon = "󱐥", color = "grey" } } )
            wk.add( { "<Leader>w", "<Cmd>w<CR>", desc = "Write", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>q", "<Cmd>qa<CR>", desc = "Quit", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>p", group = "Project", icon = { icon = "", color = "grey" } })
        end,
    },

    {
        "voldikss/vim-floaterm",
        config = function()
            vim.g.floaterm_shell = "zsh -l"
            local wk = require("which-key")
            wk.add( { "<Leader>t", "<Cmd>FloatermToggle term<CR>", mode = "n", desc = "Terminal", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>t", "<Cmd>FloatermToggle term<CR>", mode = "t", desc = "Terminal", icon = { icon = "", color = "grey" } } )
        end,
    }

}