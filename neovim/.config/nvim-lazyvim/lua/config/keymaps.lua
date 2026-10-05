-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here


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


-- Better paste
vim.keymap.set("v", "p", '"_dP')

-- center search results
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("n", "#", "#zz")

-- Helper to copy filepath with line or line range (supports normal & visual mode)
local function copy_path_and_line(opts)
  local is_absolute = opts and opts.absolute
  local mode = vim.fn.mode()
  local path = vim.fn.expand(is_absolute and "%:p" or "%:.")
  local line_str

  -- Handle visual mode line ranges (charwise 'v', linewise 'V', blockwise '\22')
  if mode:find("[vV\22]") then
    local start_line = math.min(vim.fn.line("v"), vim.fn.line("."))
    local end_line = math.max(vim.fn.line("v"), vim.fn.line("."))
    line_str = (start_line == end_line) and tostring(start_line) or string.format("%d-%d", start_line, end_line)
    -- Exit visual mode back to normal mode
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)
  else
    line_str = tostring(vim.fn.line("."))
  end

  local result = path .. ":" .. line_str
  vim.fn.setreg('"', result)
  vim.fn.setreg("+", result)
  require("osc52").copy(result) -- Pushes directly through tmux to system clipboard via OSC52
  vim.notify(string.format("Copied %s path: %s", is_absolute and "absolute" or "relative", result))
end

-- copy path+line or path+range (works in normal and visual mode)
vim.keymap.set({ "n", "x" }, "<leader>yl", function()
  copy_path_and_line({ absolute = false })
end, { desc = "Copy relative filepath:line (or range)" })

vim.keymap.set({ "n", "x" }, "<leader>yL", function()
  copy_path_and_line({ absolute = true })
end, { desc = "Copy absolute filepath:line (or range)" })

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

-- toggle diagnostics below error (virtual text and underline)
vim.keymap.set("n", "<leader>ue", function()
  local config = vim.diagnostic.config()
  local current_vt = config.virtual_text
  local current_ul = config.underline

  local is_error_only = (type(current_vt) == "table" and current_vt.severity == vim.diagnostic.severity.ERROR)
    or (
      type(current_ul) == "table"
      and type(current_ul.severity) == "number"
      and current_ul.severity == vim.diagnostic.severity.ERROR
    )

  local new_vt
  local new_ul

  if is_error_only then
    if current_vt ~= false then
      new_vt = type(current_vt) == "table" and vim.deepcopy(current_vt) or {}
      new_vt.severity = nil
    else
      new_vt = false
    end

    new_ul = (current_ul ~= false)

    vim.notify("Diagnostics below error: enabled")
  else
    if current_vt ~= false then
      new_vt = type(current_vt) == "table" and vim.deepcopy(current_vt) or {}
      new_vt.severity = vim.diagnostic.severity.ERROR
    else
      new_vt = false
    end

    if current_ul ~= false then
      new_ul = { severity = vim.diagnostic.severity.ERROR }
    else
      new_ul = false
    end

    vim.notify("Diagnostics below error: disabled")
  end

  vim.diagnostic.config({
    virtual_text = new_vt,
    underline = new_ul,
  })
end, { desc = "Toggle diagnostics below error" })
