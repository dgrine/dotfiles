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
    },

    {
        "Wansmer/treesj",
        dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
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

}
