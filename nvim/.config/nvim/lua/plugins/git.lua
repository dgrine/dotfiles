return {
    {
      "lewis6991/gitsigns.nvim",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        require("gitsigns").setup({
          signs = {
            add          = { text = "+" },
            change       = { text = "~" },
            delete       = { text = "_" },
            topdelete    = { text = "‾" },
            changedelete = { text = "~" },
            untracked    = { text = "┆" },
          },
          sign_priority = 5, -- 👈 lower than LSP (default 10)
          update_debounce = 100,
          max_file_length = 40000, -- skip huge files
          preview_config = {
            border = "rounded",
          },
          on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
            local wk = require("which-key")

            wk.add({ "<Leader>g", group = "Git", icon = { icon = "", color = "grey" } } )
            wk.add({ "<Leader>g]", function() gs.nav_hunk('next') end, desc = "Next hunk", icon = { icon = "→", color = "grey" } })
            wk.add({ "<Leader>g[", function() gs.nav_hunk('prev') end, desc = "Previous hunk", icon = { icon = "←", color = "grey" } })
            wk.add({ "<Leader>gp", gs.preview_hunk, desc = "Preview hunk", icon = { icon = "󰅓", color = "grey" } })
            wk.add({ "<Leader>gr", gs.reset_hunk, desc = "Reset hunk", icon = { icon = "󰅒", color = "grey" } })
            wk.add({ "<Leader>gs", gs.stage_hunk, desc = "Stage hunk", icon = { icon = "󰄨", color = "grey" } })
            wk.add({ "<Leader>gu", gs.undo_stage_hunk, desc = "Undo stage", icon = { icon = "", color = "grey" } })
            wk.add({ "<Leader>gb", gs.blame_line, desc = "Blame line", icon = { icon = "󰅓", color = "grey" } })
          end,
        })
      end,
    },

}
