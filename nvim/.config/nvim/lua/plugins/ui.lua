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

    -- Rosé Pine theme setup with lazy.nvim
    {
      {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,
        config = function()
          require("rose-pine").setup({
            variant = "moon", -- options: "main" (default), "moon", "dawn"
            styles = {
              bold = true,
              italic = true,
              transparency = true,
            },
          })

          vim.cmd("colorscheme rose-pine")
        end,
      },
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        config = function()
            local colors = {
              blue   = '#80a0ff',
              cyan   = '#9ccfd8',
              black  = '#191724',
              white  = '#faf4ed',
              red    = '#eb6f92',
              violet = '#c4a7e7',
              grey   = '#403d52',
            }

            local bubbles_theme = {
              normal = {
                a = { fg = colors.black, bg = colors.violet },
                b = { fg = colors.white, bg = colors.grey },
                c = { fg = colors.white },
              },

              insert = { a = { fg = colors.black, bg = colors.blue } },
              visual = { a = { fg = colors.black, bg = colors.cyan } },
              replace = { a = { fg = colors.black, bg = colors.red } },

              inactive = {
                a = { fg = colors.white, bg = colors.black },
                b = { fg = colors.white, bg = colors.black },
                c = { fg = colors.white },
              },
            }

            require('lualine').setup {
              options = {
                theme = bubbles_theme,
                component_separators = '',
                section_separators = { left = '', right = '' },
              },
              sections = {
                lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
                lualine_b = { 'filename', 'branch', 'diff' },
                lualine_c = {
                  'diagnostics',
                  '%=',
                },
                lualine_x = {},
                lualine_y = { 'filetype', 'progress' },
                lualine_z = {
                  { 'location', separator = { right = '' }, left_padding = 2 },
                },
              },
              inactive_sections = {
                lualine_a = { 'filename' },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { 'location' },
              },
              tabline = {},
              extensions = {},
            }
        end,
    },

}
