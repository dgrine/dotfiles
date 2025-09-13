return {
	{
		"lervag/vimtex",
		enabled = not vim.g.vscode,
		init = function()
			-- Viewer
			-- vim.g.vimtex_view_method = "zathura"
			if vim.fn.has("macunix") then
				vim.g.vimtex_view_method = "skim" -- Choose which program to use to view PDF file
				vim.g.vimtex_view_skim_sync = 1 -- Value 1 allows forward search after every successful compilation
				vim.g.vimtex_view_skim_activate = 1 -- Value 1 allows change focus to skim after command `:VimtexView` is given
			end

			-- compiler
			-- > latexmk: continuous builds, however shell-escape via .latexmkrc
			vim.g.vimtex_compiler_method = "latexmk"
			vim.g.vimtex_compiler_latexmk = {
				options = {
					"-verbose",
					-- "-file-line-error",
					-- "-synctex=1",
					-- "-interaction=nonstopmode",
					"-shell-escape",
					-- "-pdflatex=pdftex",
				},
			}
			-- > latexrun: no continuous builds, built-in shell-escape
			-- vim.g.vimtex_compiler_method = "latexrun"
			-- vim.g.vimtex_compiler_latexrun = { options = { "--latex-args='--shell-escape'" } }

			-- Disable insert mode mappings
			vim.g.vimtex_imaps_enabled = 0
		end,
		config = function()
			local wk = require("which-key")
			wk.add({ "<Leader>l", group = "Latex", icon = { icon = "", color = "grey" } })
		end,
	},
}
