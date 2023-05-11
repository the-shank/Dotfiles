local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local status_ok, trouble = pcall(require, "trouble.providers.telescope")
if not status_ok then
	print("failed: loading trouble")
	return
end

local actions = require("telescope.actions")

telescope.setup({
	defaults = {

		prompt_prefix = " ",
		selection_caret = " ",
		-- path_display = { "smart" },
		file_ignore_patterns = { ".git/", "node_modules" },

		mappings = {
			i = {
				["<Down>"] = actions.cycle_history_next,
				["<Up>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<A-d>"] = actions.delete_buffer,
				["<C-t>"] = trouble.open_with_trouble,
			},
		},
	},
})
