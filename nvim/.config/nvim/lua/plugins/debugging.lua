return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            require("dapui").setup()
            local dap, dapui =require("dap"),require("dapui")
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
            wk.add( { "<Leader>du", dapui.toggle, desc = "UI", icon = { icon = "", color = "grey" } } )
        end,
    },

    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
            local dap = require("dap")
            local wk = require("which-key")
            wk.add( { "<Leader>d", group = "Debug", icon = { icon = "", color = "grey" } } )
            wk.add( {
                "<Leader>dl", 
                function()
                    if vim.bo.filetype == "cpp" then
                        -- (Re-)reads launch.json if present
                        if vim.fn.filereadable(".vscode/launch.json") then
                            require("dap.ext.vscode").load_launchjs(nil, { cpptools = { "c", "cpp" } })
                        end
                    end
                    dap.continue()
                end,
                desc = "Launch",
                icon = { icon = "", color = "green" },
            } )
            wk.add( { "<Leader>dc", dap.continue, desc = "Continue", icon = { icon = "", color = "green" } } )
            wk.add( { "<Leader>ds", dap.step_over, desc = "Step", icon = { icon = "󱞯", color = "grey" } } )
            wk.add( { "<Leader>di", dap.step_into, desc = "Step in", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>do", dap.step_out, desc = "Step out", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>db", dap.toggle_breakpoint, desc = "Breakpoint", icon = { icon = "", color = "grey" } } )
            wk.add( { "<Leader>dq", dap.terminate, desc = "Quit", icon = { icon = "", color = "grey" } } )

            --
            -- DAP-Client ----- Debug Adapter ------- Debugger ------ Debugee
            -- (nvim-dap)  |   (per language)  |   (per language)    (your app)
            --             |                   |
            --             |        Implementation specific communication
            --             |        Debug-adapter and debugger could be the same process
            --             |
            --      Communication via debug adapter protocol
            --
            -- The debug adapter can be for example codelldb and the debugger lldb.
            --
            -- dap.adapters defines how to start the debug adapter
            -- dap.configurations defines how to start the debugee.

            dap.adapters.lldb = {
              type = "server",
              port = "${port}",
              executable = {
                command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
                args = {"--port", "${port}"},
                -- On windows you may have to uncomment this:
                -- detached = false,
              }
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
            dap.adapters.python = function(cb, config)
                if config.request == "attach" then
                    ---@diagnostic disable-next-line: undefined-field
                    local port = (config.connect or config).port
                    ---@diagnostic disable-next-line: undefined-field
                    local host = (config.connect or config).host or "127.0.0.1"
                    cb({
                        type = "server",
                        port = assert(port, "`connect.port` is required for a python `attach` configuration"),
                        host = host,
                        options = {
                            source_filetype = "python",
                        },
                    })
                else
                    cb({
                        type = "executable",
                        command = "python",
                        args = { "-m", "debugpy.adapter" },
                        options = {
                            source_filetype = "python",
                        },
                    })
                end
            end
            dap.configurations.python = {
                {
                    -- The first three options are required by nvim-dap
                    type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
                    request = "launch",
                    name = "Launch file",
                    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
                    program = "${file}", -- This configuration will launch the current file if used.
                    pythonPath = function()
                        -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
                        -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
                        -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
                        local cwd = vim.fn.getcwd()
                        if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                            return cwd .. "/venv/bin/python"
                        elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                            return cwd .. '/.venv/bin/python'
                        else
                            return "/usr/bin/python"
                        end
                    end,
                    env = {
                        PYTHONPATH = vim.fn.getcwd() .. "/code/py"
                    },
                },
            }
        end,
    },

    {
        "theHamsta/nvim-dap-virtual-text",
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
        config = function()
            require("nvim-dap-repl-highlights").setup()
        end,
    },

    {
        "mfussenegger/nvim-dap-python",
        config = function()
            require("dap-python").setup("python")
        end,
    },

}
