local status_ok, tree_sitter_just = pcall(require, "tree-sitter-just")
if not status_ok then
	return
end

-- NOTE: This just registers the parser with treesitter. You would have to manually install the parser (:TSInstall just)
tree_sitter_just.setup({})
