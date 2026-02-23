-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- toggle background (light/dark)
vim.keymap.set("n", "<leader>tt", function()
  local current_bg = vim.o.background
  if current_bg == "light" then
    vim.o.background = "dark"
  else
    vim.o.background = "light"
  end
end, { desc = "toggle light/dark theme" })

-- copilot enable
vim.keymap.set("n", "<leader>pe", function()
  vim.cmd("Copilot enable")
  print("Copilot enabled")
end, { desc = "Copilot enable" })

-- copilot disable
vim.keymap.set("n", "<leader>pd", function()
  vim.cmd("Copilot disable")
  print("Copilot disabled")
end, { desc = "Copilot disable" })

-- copilot status
vim.keymap.set("n", "<leader>ps", function()
  vim.cmd("Copilot status")
end, { desc = "Copilot status" })

-- copilot-chat
vim.keymap.set("v", "<leader>ae", function()
  vim.cmd("CopilotChatExplain")
end, { desc = "CopilotChatExplain" })

-- Better paste
vim.keymap.set("v", "p", '"_dP')

-- center search results
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("n", "#", "#zz")

-- copy path+line_num (for using in gdb)
vim.keymap.set("n", "<leader>yl", function()
  local path = vim.fn.expand("%:.")
  local line = vim.fn.line(".")
  local result = path .. ":" .. line
  vim.fn.setreg('"', result)
  require("osc52").copy(result) -- Pushes directly through tmux to system clipboard via OSC52
  vim.notify("Copied relative path: " .. result)
end, { desc = "Copy relative filepath:line" })

-- copy path+line_num (for using in gdb)
vim.keymap.set("n", "<leader>yL", function()
  local path = vim.fn.expand("%:p")
  local line = vim.fn.line(".")
  local result = path .. ":" .. line
  vim.fn.setreg('"', result)
  require("osc52").copy(result) -- Pushes directly through tmux to system clipboard via OSC52
  vim.notify("Copied relative path: " .. result)
end, { desc = "Copy absolute filepath:line" })

-- copy file path (relative)
vim.keymap.set("n", "<leader>yp", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg('"', path)
  require("osc52").copy(path) -- Pushes directly through tmux to system clipboard via OSC52
  vim.notify("Copied relative path: " .. path)
end, { desc = "Copy relative file path" })

-- copy file path (absolute)
vim.keymap.set("n", "<leader>yP", function()
  local path = vim.fn.expand("%:p")
  require("osc52").copy(path) -- Pushes directly through tmux to system clipboard via OSC52
  vim.notify("Copied absolute path: " .. path)
end, { desc = "Copy absolute file path" })

-- toggle virtual_text for diagnostic
vim.keymap.set("n", "<leader>uD", function()
  local virtual_text_enabled = vim.diagnostic.config().virtual_text
  virtual_text_enabled = not virtual_text_enabled
  vim.diagnostic.config({ virtual_text = virtual_text_enabled })
  if virtual_text_enabled then
    print("Diagnostic virtual_text enabled")
  else
    print("Diagnostic virtual_text disabled")
  end
end, { desc = "toggle diagnostic virtual_text" })

-- toggle warning diagnostics
local diagnostic_below_error_disabled = false
local backup_diagnostic_config = nil

local error_only_diagnostic_config = {
  underline = { severity = { min = vim.diagnostic.severity.ERROR } },
  virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
  signs = { severity = { min = vim.diagnostic.severity.ERROR } },
}

vim.keymap.set("n", "<leader>tw", function()
  if diagnostic_below_error_disabled then
    if backup_diagnostic_config then
      vim.diagnostic.config(backup_diagnostic_config)
      backup_diagnostic_config = nil
    end
    diagnostic_below_error_disabled = false
    vim.notify("Diagnostics restored to previous settings")
  else
    backup_diagnostic_config = vim.diagnostic.config()
    vim.diagnostic.config(error_only_diagnostic_config)
    diagnostic_below_error_disabled = true
    print("Diagnostics below error disabled")
  end
end, { desc = "toggle diagnostic below error" })
