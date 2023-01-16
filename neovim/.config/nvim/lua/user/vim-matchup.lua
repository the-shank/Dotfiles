local status_ok, matchup = pcall(require, "vim-matchup")
if not status_ok then
	print("vim-matchup not installed")
	return
end

vim.g.matchup_matchparen_offscreen = { method = "popup" }
