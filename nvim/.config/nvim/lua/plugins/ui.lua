return {
    {
        "nvim-tree/nvim-web-devicons",
    },

    {
        "echasnovski/mini.icons",
        opts = {},
        lazy = true,
        specs = {
            { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
        },
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },

    {
        "stevearc/dressing.nvim",
        opts = {},
    },

    {
        "ziontee113/icon-picker.nvim",
        config = function()
            require("icon-picker").setup({ disable_legacy_commands = true })

            local opts = { noremap = true, silent = true }

            local wk = require("which-key")
            wk.add( { "<Leader>i", "<Cmd>:IconPickerNormal<CR>", desc = "Icons", icon = { icon = "󰱨", color = "grey" } } )
            -- vim.keymap.set("i", "<C-i>", "<cmd>IconPickerInsert<cr>", opts)
        end
    },

    -- the colorscheme should be available when starting Neovim
    {
        "sainnhe/sonokai",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme sonokai]])
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        config = function()
            require("lualine").setup {
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
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
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = { "encoding", "fileformat", "filetype", },
                    lualine_y = { "progress" },
                    lualine_z = { "location" }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {},
            }
        end,
    },

}
