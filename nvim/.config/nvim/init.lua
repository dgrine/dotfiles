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
--- (3) DAP: Dispatch viewer based on variable type
-------------------------------------------------------
local function handle_dataframe(expr, session, frame_id)
	local feather_path = vim.fn.tempname() .. ".feather"
	local py = string.format([[%s.reset_index().to_feather(r"%s")]], expr, feather_path)

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
		local cmd = string.format([[vd "%s"]], feather_path)
		if os.getenv("TMUX") then
			vim.fn.jobstart({ "tmux", "split-window", "-v", cmd }, { detach = true })
		else
			vim.cmd("botright split | resize 12")
			vim.cmd("terminal " .. cmd)
			vim.cmd("startinsert")
		end
		vim.schedule(function()
			vim.notify("Opened DataFrame in VisiData (typed): " .. feather_path, vim.log.levels.INFO)
		end)
	end)
end

local function handle_numpy_array(expr, session, frame_id)
	local wrapped_expr =
		string.format("__import__('pandas').DataFrame(%s.reshape(-1, 1) if %s.ndim == 1 else %s)", expr, expr, expr)
	handle_dataframe(wrapped_expr, session, frame_id)
end

local function dap_view_variable()
	local dap = require("dap")
	local session = dap.session()
	if not session then
		vim.notify("DAP: no active session.", vim.log.levels.ERROR)
		return
	end

	local expr = vim.fn.input({ prompt = "Variable name: ", default = "df" })
	if not expr or expr == "" then
		return
	end

	local function resolve_and_dispatch(frame_id)
		if not frame_id then
			vim.notify("DAP: no frame id available for evaluation.", vim.log.levels.ERROR)
			return
		end

		-- Evaluate the type of the variable
		local type_expr = string.format([[type(%s).__name__]], expr)
		session:request(
			"evaluate",
			{ expression = type_expr, context = "repl", frameId = frame_id },
			function(err, resp)
				if err or not resp or not resp.result then
					vim.schedule(function()
						vim.notify(
							"Could not resolve type of variable: " .. tostring(err and err.message or ""),
							vim.log.levels.ERROR
						)
					end)
					return
				end

				local typename = resp.result:gsub("^['\"](.-)['\"]$", "%1")
				if typename == "DataFrame" then
					handle_dataframe(expr, session, frame_id)
				elseif typename == "ndarray" then
					handle_numpy_array(expr, session, frame_id)
				else
					vim.notify("Unsupported type: " .. typename, vim.log.levels.WARN)
				end
			end
		)
	end

	local frame = session.current_frame
	if frame and frame.id then
		resolve_and_dispatch(frame.id)
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
			resolve_and_dispatch(top and top.id or nil)
		end)
	end
end

vim.keymap.set("n", "<Leader>dv", dap_view_variable, { desc = "View in VisiData" })
