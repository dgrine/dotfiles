return {
	{
		"rcarriga/nvim-dap-ui",
		enabled = not vim.g.vscode,
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			require("dapui").setup()
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
			local wk = require("which-key")
			wk.add({ "<Leader>du", dapui.toggle, desc = "UI", icon = { icon = "", color = "grey" } })
		end,
	},

	{
		"williamboman/mason.nvim",
		enabled = not vim.g.vscode,
		config = function()
			require("mason").setup()

			-- Helper to resolve project-local Python
			local function venv_python()
				local cwd = vim.fn.getcwd()
				local cands = {
					cwd .. "/.venv/bin/python",
					cwd .. "/venv/bin/python",
				}
				for _, p in ipairs(cands) do
					if vim.fn.executable(p) == 1 then
						return p
					end
				end
				if vim.fn.executable("python3") == 1 then
					return "python3"
				end
				return "python"
			end

			local dap = require("dap")
			local wk = require("which-key")

			wk.add({ "<Leader>d", group = "Debug", icon = { icon = "", color = "grey" } })
			wk.add({
				"<Leader>dl",
				function()
					if vim.bo.filetype == "cpp" then
						if vim.fn.filereadable(".vscode/launch.json") == 1 then
							require("dap.ext.vscode").load_launchjs(nil, { cpptools = { "c", "cpp" } })
						end
					end
					dap.continue()
				end,
				desc = "Launch",
				icon = { icon = "", color = "green" },
			})
			wk.add({ "<Leader>dc", dap.continue, desc = "Continue", icon = { icon = "", color = "green" } })
			wk.add({ "<Leader>ds", dap.step_over, desc = "Step", icon = { icon = "󱞯", color = "grey" } })
			wk.add({ "<Leader>di", dap.step_into, desc = "Step in", icon = { icon = "", color = "grey" } })
			wk.add({ "<Leader>do", dap.step_out, desc = "Step out", icon = { icon = "", color = "grey" } })
			wk.add({ "<Leader>db", dap.toggle_breakpoint, desc = "Breakpoint", icon = { icon = "", color = "grey" } })
			wk.add({ "<Leader>dq", dap.terminate, desc = "Quit", icon = { icon = "", color = "grey" } })

			local neotest = require("neotest")
			wk.add({
				"<Leader>dt",
				function()
					neotest.run.run({ strategy = "dap" })
				end,
				desc = "Test",
				icon = { icon = "󰈙", color = "grey" },
			})

			-- lldb (C/C++)
			dap.adapters.lldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
					args = { "--port", "${port}" },
					-- detached = false, -- windows tweak if needed
				},
			}
			dap.configurations.cpp = {
				{
					name = "Executable...",
					type = "lldb",
					request = "launch",
					program = function()
						return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					args = function()
						local args = vim.fn.input("Arguments: ", "", "file")
						return args ~= "" and { args } or nil
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = true,
					initCommands = { "breakpoint set -n main -N entry" },
					exitCommands = { "breakpoint delete entry" },
				},
			}

			-- Python adapter (use project venv)
			dap.adapters.python = function(cb, config)
				if config.request == "attach" then
					local port = (config.connect or config).port
					local host = (config.connect or config).host or "127.0.0.1"
					cb({
						type = "server",
						port = assert(port, "`connect.port` is required for a python `attach` configuration"),
						host = host,
						options = { source_filetype = "python" },
					})
				else
					cb({
						type = "executable",
						command = venv_python(), -- <- ensure adapter runs from venv
						args = { "-m", "debugpy.adapter" },
						options = { source_filetype = "python" },
					})
				end
			end

			-- Python launch configurations (also use venv)
			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					pythonPath = venv_python, -- <- debugee uses same venv
					justMyCode = false,
					console = "integratedTerminal",
					env = {
						PYTHONPATH = vim.fn.getcwd() .. "/code/py",
					},
				},
				{
					type = "python",
					request = "launch",
					name = "Debug current test (pytest)",
					module = "pytest",
					args = function()
						return { vim.fn.expand("%") }
					end,
					pythonPath = venv_python, -- <- pytest uses same venv
					justMyCode = false,
					console = "integratedTerminal",
				},
			}
		end,
	},

	{
		"theHamsta/nvim-dap-virtual-text",
		enabled = not vim.g.vscode,
		config = function()
			require("nvim-dap-virtual-text").setup({
				commented = true,
				virt_text_pos = "eol",
			})
		end,
	},

	-- Note: :TSInstall dap_repl after installation
	{
		"LiadOz/nvim-dap-repl-highlights",
		enabled = not vim.g.vscode,
		config = function()
			require("nvim-dap-repl-highlights").setup()
		end,
	},

	{
		"mfussenegger/nvim-dap-python",
		enabled = not vim.g.vscode,
		config = function()
			-- Recreate helper locally (this module runs in its own scope)
			local function venv_python()
				local cwd = vim.fn.getcwd()
				local cands = {
					cwd .. "/.venv/bin/python",
					cwd .. "/venv/bin/python",
				}
				for _, p in ipairs(cands) do
					if vim.fn.executable(p) == 1 then
						return p
					end
				end
				if vim.fn.executable("python3") == 1 then
					return "python3"
				end
				return "python"
			end

			local dppy = require("dap-python")
			dppy.setup(venv_python()) -- <- make dap-python use the venv
			dppy.test_runner = "pytest"
		end,
	},
}
