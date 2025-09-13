return {
	{
		"nvim-neotest/neotest",
		enabled = not vim.g.vscode,
		dependencies = {
			"antoinemadec/FixCursorHold.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-neotest/neotest-python",
			"nvim-neotest/nvim-nio",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			local neotest = require("neotest")
			neotest.setup({
				adapters = {
					require("neotest-python")({
						dap = { justMyCode = true },
						runer = "pytest",
					}),
				},
			})
			local wk = require("which-key")
			wk.add({ "<Leader>t", group = "Test", icon = { icon = "", color = "grey" } })
			wk.add({ "<Leader>tt", neotest.run.run, desc = "Nearest", icon = { icon = "", color = "grey" } })
			wk.add({
				"<Leader>td",
				function()
					neotest.run.run(vim.fn.expand("%"))
				end,
				desc = "Document",
				icon = { icon = "󰈙", color = "grey" },
			})
			wk.add({
				"<Leader>to",
				neotest.output_panel.toggle,
				desc = "Output",
				icon = { icon = "", color = "grey" },
			})
			wk.add({ "<Leader>ts", neotest.summary.toggle, desc = "Summary", icon = { icon = "", color = "grey" } })
		end,
	},
}
