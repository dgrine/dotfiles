return {
    {
        "airblade/vim-gitgutter",
        lazy = false,
        config = function()
            vim.g.gitgutter_map_keys = 0
        end
    },

    {
        "tpope/vim-fugitive",
        lazy = false,
        config = function()
            local telescope = require("telescope.builtin")
            local wk = require("which-key")
            wk.add( { "<Leader>g", group = "Git", icon = { icon = "", color = "grey" } } )
            -- wk.add( { "<Leader>gs", group = "Status", icon = { icon = "", color = "grey" } } )
            -- wk.add( { "<Leader>gse", "<Cmd>Git<CR>", desc = "Extended", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>gs",telescope.git_status, desc = "Status", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>gd", "<Cmd>Gvdiffsplit<CR>", desc = "Diff", icon = { icon = "󰦒", color = "grey" } } )
            wk.add( { "<Leader>gh", "<Cmd>0Gllog<CR>", desc = "History", icon = { icon = "󰅓", color = "grey" } } )
            wk.add( { "<Leader>g[", "<Plug>(GitGutterPrevHunk)", desc = "Previous hunk", icon = { icon = "↩", color = "grey" } } )
            wk.add( { "<Leader>g]", "<Plug>(GitGutterNextHunk)", desc = "Next hunk", icon = { icon = "↪", color = "grey" } } )
        end,
    }

}
