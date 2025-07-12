return {
	-- Note: There is an issue with using TSInstall under alacritty, the `arch` command incorrectly
	-- reports that the architecture is i386 instead of arm64. So it is best to use a different terminal
	-- when installing parsers.
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })()
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
				indent = { enable = true },
				ensure_installed = {
					"bash",
					"css",
					"javascript",
					"json",
					"lua",
					"markdown",
					"python",
					"scss",
					"typescript",
					"yaml",
				},
			})
		end,
	},

	-- Comment out code
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({})
			local wk = require("which-key")
			wk.add({ "<Leader>c", group = "Code", icon = { icon = "", color = "grey" } })
			wk.add({
				"<Leader>c<Space>",
				"<Cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
				desc = "Toggle comment",
				icon = { icon = "󰓯", color = "grey" },
			})
		end,
	},

	-- Visual multi-cursor editing
	{
		"mg979/vim-visual-multi",
		lazy = false,
	},

	-- Surround text with characters
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	-- Pretty quickfix window
	{
		"yorickpeterse/nvim-pqf",
		config = function()
			require("pqf").setup()
		end,
	},

	-- Highlight colors in code
	{
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup()
		end,
	},

	-- Switch between values (e.g., true/false, on/off)
	{
		"AndrewRadev/switch.vim",
		config = function()
			vim.g.switch_mapping = ""
			local wk = require("which-key")
			wk.add({ "<Leader>ct", "<Cmd>Switch<CR>", desc = "Toggle value", icon = { icon = "󰓤", color = "grey" } })
		end,
	},

	-- Run commands asynchronously
	{ "tpope/vim-dispatch" },

	-- GitHub Copilot
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		-- event = "InsertEnter",
		event = "VeryLazy",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = true,
					auto_refresh = true,
					keymap = {
						jump_prev = "<M-[[>",
						jump_next = "<M-]]>",
						accept = "<M-l>",
						refresh = "gr",
						open = "<M-CR>",
					},
					layout = {
						position = "bottom", -- | top | left | right
						ratio = 0.2,
					},
				},
				suggestion = {
					auto_trigger = true,
				},
			})
			require("copilot.suggestion").toggle_auto_trigger()
		end,
	},

	-- Render markdown in a floating window, used by Code Companion
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "codecompanion" },
		config = function()
			-- apply the highlight fix
			vim.api.nvim_set_hl(0, "RenderMarkdownCode", { blend = 100 })
		end,
	},

	-- Lazy.nvim config for nvim-cmp + Mason + LSPs + Formatters + Linting + Copilot
	-- 1. Completion engine
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = { "rafamadriz/friendly-snippets" },

		-- use a release tag to download pre-built binaries
		version = "1.*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			-- keymap = { preset = 'default' },
			keymap = {
				preset = "none",
				["<A-k>"] = { "select_prev", "fallback_to_mappings" },
				["<A-j>"] = { "select_next", "fallback_to_mappings" },
				["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide" },
				["<Tab>"] = { "select_and_accept" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
				["<C-n>"] = { "snippet_forward", "fallback" },
				["<C-p>"] = { "snippet_backward", "fallback" },
				["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
			},

			signature = { enabled = true },

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = { documentation = { auto_show = false } },

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "codecompanion" },
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},

	-- 2. Snippet engine
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},

	-- 3. Mason for installing LSPs, formatters, linters
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				-- These are the LSPs that will be installed automatically
				ensure_installed = {
					"clangd", -- C++
					"pyright", -- Python
					"ts_ls", -- TypeScript / JavaScript
					"lua_ls", -- Lua
					"html", -- HTML
				},
			})

			vim.keymap.set("n", "gl", function()
				vim.diagnostic.open_float(nil, { focusable = false, border = "rounded", source = "always" })
			end, { desc = "Show diagnostic under cursor" })
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				-- These are the formatters and linters that will be installed automatically
				ensure_installed = {
					"prettier",
					"isort",
					"black",
					"clang_format",
					"eslint_d",
					"stylua",
				},
				automatic_setup = true,
			})
			local null_ls = require("null-ls")

			-- Register formatters
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.isort,
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.clang_format,
					null_ls.builtins.formatting.stylua,
				},
			})
			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function(args)
					vim.lsp.buf.format({
						bufnr = args.buf,
						async = false,
						filter = function(client)
							return client.name == "null-ls"
						end,
					})
				end,
			})
		end,
	},

	-- 4. Native LSP client config
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local wk = require("which-key")
			local ts = require("telescope.builtin")

			wk.add({ "<Leader>c", group = "Code", icon = { icon = "", color = "grey" } })

			-- Diagnostics
			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function()
					vim.diagnostic.open_float(nil, {
						focusable = false,
						border = "rounded",
						source = "always",
						prefix = "",
						scope = "cursor",
					})
				end,
			})

			-- Groups
			wk.add({ "<Leader>cd", group = "Diagnostic", icon = { icon = "", color = "grey" } })
			wk.add({ "<Leader>cs", group = "Symbols", icon = { icon = "", color = "grey" } })

			-- Diagnostics
			wk.add({ "<Leader>cd]", vim.diagnostic.goto_next, desc = "Next", icon = { icon = "→", color = "grey" } })
			wk.add({
				"<Leader>cd[",
				vim.diagnostic.goto_prev,
				desc = "Previous",
				icon = { icon = "←", color = "grey" },
			})
			-- Actions
			wk.add({
				"<Leader>csr",
				vim.lsp.buf.rename,
				desc = "Rename symbol",
				icon = { icon = "󰒡", color = "grey" },
			})

			-- Telescope
			wk.add({ "<Leader>cdd", ts.diagnostics, desc = "Diagnostics", icon = { icon = "", color = "grey" } })
			wk.add({ "gd", ts.lsp_definitions, desc = "Go to definition", icon = { icon = "", color = "grey" } })
			wk.add({
				"<Leader>cc",
				ts.lsp_definitions,
				desc = "Go to definition",
				icon = { icon = "", color = "grey" },
			})
			wk.add({ "gr", ts.lsp_references, desc = "References", icon = { icon = "", color = "grey" } })
			wk.add({ "gi", ts.lsp_incoming_calls, desc = "Incoming calls", icon = { icon = "󰕮", color = "grey" } })
			wk.add({ "go", ts.lsp_incoming_calls, desc = "Outgoing calls", icon = { icon = "󰕮", color = "grey" } })
			wk.add({
				"<Leader>csd",
				"<Cmd>Telescope aerial<CR>",
				desc = "Document",
				icon = { icon = "󰈭", color = "grey" },
			})
			wk.add({
				"<Leader>csw",
				ts.lsp_dynamic_workspace_symbols,
				desc = "Workspace",
				icon = { icon = "󰈭", color = "grey" },
			})
		end,
	},

	-- 5. Code Companion
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"Saghen/blink.cmp",
		},
		config = function()
			require("codecompanion").setup({})
		end,
	},

	{
		"stevearc/aerial.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("aerial").setup({
				backends = { "treesitter", "lsp" },
				attach_mode = "global",
				show_guides = true,
				show_guide_icons = true,
				show_cursor = true,
				show_unnamed = false,
				close_on_select = true,
				link_tree_to_folds = true,
				filter_kind = {
					"Class",
					"Constructor",
					"Enum",
					"Function",
					"Interface",
					"Module",
					"Method",
					"Struct",
					"Trait",
					-- optionally:
					-- "Namespace",
					-- "Package",
				},
			})
			local wk = require("which-key")
			wk.add({
				"<Leader>cso",
				"<Cmd>AerialToggle!<CR>",
				desc = "Outline",
				icon = { icon = "󰈭", color = "grey" },
			})
		end,
	},
}
