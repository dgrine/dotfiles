require("config.lazy")

-------------------------------------------------------
--- (1) Which-key group and icon for AI-related commands
-------------------------------------------------------
local wk = require("which-key")
wk.add({ "<Leader>a", group = "AI", icon = { icon = "", color = "grey" } })

-------------------------------------------------------
--- (2) DAP: Prevent LSP from attaching to DAP / dap-ui buffers
-------------------------------------------------------
-- Never let LSP attach to DAP / dap-ui buffers
-- Keep LSP clients off DAP buffers, but do NOT change buftype/filetype
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"dap-repl",
		"dapui_console",
		"dapui_watches",
		"dapui_stacks",
		"dapui_breakpoints",
		"dapui_scopes",
	},
	callback = function(ev)
		-- Detach any LSP clients that auto-attached
		for _, client in pairs(vim.lsp.get_active_clients({ bufnr = ev.buf })) do
			pcall(vim.lsp.buf_detach_client, ev.buf, client.id)
		end
		-- DO NOT touch buftype here; dap-repl needs buftype=prompt
		-- If you had previous config that set buftype, remove it.
	end,
})

-------------------------------------------------------
--- (3) DAP: View Pandas DataFrame in VisiData
-------------------------------------------------------
-- Put this anywhere after nvim-dap is loaded
local function dap_show_df_in_visidata()
	local dap = require("dap")
	local session = dap.session()
	if not session then
		vim.notify("DAP: no active session.", vim.log.levels.ERROR)
		return
	end

	local expr = vim.fn.input({ prompt = "DataFrame expr: ", default = "df" })
	if not expr or expr == "" then
		return
	end

	local csv_path = vim.fn.tempname() .. ".csv"
	local py = string.format([[%s.to_csv(r"%s", index=False)]], expr, csv_path)

	-- helper to run evaluate once we have a frame id
	local function evaluate_in_frame(frame_id)
		if not frame_id then
			vim.notify("DAP: no frame id available for evaluation.", vim.log.levels.ERROR)
			return
		end
		session:request("evaluate", { expression = py, context = "repl", frameId = frame_id }, function(err, _)
			if err then
				vim.schedule(function()
					vim.notify("Export failed: " .. tostring(err.message or err), vim.log.levels.ERROR)
				end)
				return
			end
			if vim.fn.executable("vd") == 0 then
				vim.schedule(function()
					vim.notify("VisiData (vd) not found in PATH.", vim.log.levels.ERROR)
				end)
				return
			end
			local cmd = string.format([[vd "%s"]], csv_path)
			if os.getenv("TMUX") then
				vim.fn.jobstart({ "tmux", "split-window", "-v", cmd }, { detach = true })
			else
				vim.cmd("botright split | resize 12")
				vim.cmd("terminal " .. cmd)
				vim.cmd("startinsert")
			end
			vim.schedule(function()
				vim.notify("Opened DataFrame in VisiData: " .. csv_path, vim.log.levels.INFO)
			end)
		end)
	end

	-- try to use the currently selected frame; otherwise query top frame
	local frame = session.current_frame
	if frame and frame.id then
		evaluate_in_frame(frame.id)
	else
		local thread_id = session.stopped_thread_id
		if not thread_id then
			vim.notify("DAP: no stopped thread.", vim.log.levels.ERROR)
			return
		end
		session:request("stackTrace", { threadId = thread_id, startFrame = 0, levels = 1 }, function(err, resp)
			if err then
				vim.schedule(function()
					vim.notify("stackTrace error: " .. tostring(err.message or err), vim.log.levels.ERROR)
				end)
				return
			end
			local top = resp and resp.stackFrames and resp.stackFrames[1]
			evaluate_in_frame(top and top.id or nil)
		end)
	end
end

vim.keymap.set("n", "<Leader>dv", dap_show_df_in_visidata, { desc = "View DataFrame in VisiData" })
