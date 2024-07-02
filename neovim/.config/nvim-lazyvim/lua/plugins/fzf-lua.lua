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
    { "<leader><space>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    { "<leader>tl", toggle_preview_layout, desc = "(fzf-lua) toggle preview layout" },
  },
}
