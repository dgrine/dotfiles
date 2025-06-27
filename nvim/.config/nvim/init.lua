require("config.lazy")

-- Add code companion keybindings
local wk = require("which-key")
wk.add( { "<Leader>a", group = "AI", icon = { icon = "", color = "grey" } } )
wk.add( { "<Leader>aa", "<Cmd>CodeCompanion<CR>", desc = "Inline", icon = { icon = "", color = "grey" } } )
wk.add( { "<Leader>ac", "<Cmd>CodeCompanionChat<CR>", desc = "Chat", icon = { icon = "󰭹", color = "grey" } } )
wk.add( { "<Leader>al", "<Cmd>CodeCompanionActions<CR>", desc = "Actions", icon = { icon = "", color = "grey" } } )
