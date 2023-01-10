local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
	return
end

local dap_install_status_ok, dap_install = pcall(require, "dap-install")
if not dap_install_status_ok then
	return
end

dap_install.setup({})

dap_install.config("python", {})
-- add other configs here

-- rust (start)
dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = "/usr/bin/codelldb",
		args = { "--port", "${port}" },
	},
}

dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode",
	name = "lldb",
}

local codelldb = {
	name = "Rust debug (codelldb)",
	type = "codelldb",
	request = "launch",
	program = function()
		return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
	end,
	-- program = function()
	-- 	vim.fn.jobstart({ "cargo", "build" }, {
	-- 		on_exit = function(_, code)
	-- 			if code == 0 then
	-- 				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
	-- 			end
	-- 		end,
	-- 	})
	-- end,
	cwd = "${workspaceFolder}",
	stopOnEntry = true,
	showDisassembly = "never",
}

local lldb = {
	name = "Rust debug (lldb)",
	type = "lldb",
	request = "launch",
	program = function()
		return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug", "file")
	end,
	cwd = "${workspaceFolder}",
	stopOnEntry = true,
	showdisassembly = "never",
}

dap.configurations.rust = {
	codelldb,
    lldb,
}
-- rust (end)

dapui.setup({
	expand_lines = true,
	icons = { expanded = "", collapsed = "", circular = "" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.33 },
				{ id = "breakpoints", size = 0.17 },
				{ id = "stacks", size = 0.25 },
				{ id = "watches", size = 0.25 },
			},
			size = 0.33,
			position = "right",
		},
		{
			elements = {
				{ id = "repl", size = 0.45 },
				{ id = "console", size = 0.55 },
			},
			size = 0.27,
			position = "bottom",
		},
	},
	floating = {
		max_height = 0.9,
		max_width = 0.5, -- Floats will be treated as percentage of your screen.
		border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
})

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
