local function toggle_preview_layout()
  local fzf = require("fzf-lua")
  local current_layout = fzf.config.defaults.preview_layout
  if current_layout == "vertical" then
    fzf.config.defaults.preview_layout = "horizontal"
  else
    fzf.config.defaults.preview_layout = "vertical"
  end
  print("Preview layout changed to: " .. fzf.config.defaults.preview_layout)
end

local function search_in_selected_folder()
  -- First, use fzf-lua to select a directory
  require("fzf-lua").files({
    prompt = "Select directory> ",
    cmd = "fd --type d --hidden --follow --exclude .git",
    actions = {
      -- Override the default selection action
      ["default"] = function(selected)
        print(vim.inspect(selected))
        local selected_dir = selected[1]
        selected_dir = selected_dir:gsub("[^%w%/%.%-_$]", "")
        print("Selected directory (cleaned): " .. selected_dir)
        if selected_dir then
          -- After directory is selected, search files in it
          require("fzf-lua").files({
            prompt = "🔍 " .. selected_dir .. "> ",
            cwd = selected_dir,
            cmd = "fd --type f --hidden --follow --exclude .git",
          })
        end
      end,
    },
  })
end

vim.api.nvim_create_user_command(
  "SearchInSelected",
  search_in_selected_folder,
  { desc = "Search files in an interactively selected directory" }
)

return {
  "ibhagwan/fzf-lua",
  opts = {
    winopts = {
      height = 0.95,
      width = 0.95,
      preview = {
        horizontal = "right:55%",
      },
    },
  },
  keys = {
    -- { "<leader><space>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    { "<leader><space>", LazyVim.pick("files", { cwd = vim.fn.getcwd() }), desc = "Find Files (CWD)" },
    { "<leader>tl", toggle_preview_layout, desc = "(fzf-lua) toggle preview layout" },
    { "<leader>fid", search_in_selected_folder, desc = "(fzf-lua) search files in selected directory" },
  },
}
