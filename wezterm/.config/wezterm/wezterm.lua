local wezterm = require("wezterm")

return {
	-- font
	-- font = wezterm.font("Iosevka Nerd Font", {
	-- font = wezterm.font("NotoSansMono Nerd Font", {
	font = wezterm.font("FiraCode Nerd Font", {
		-- weight = "Regular",
		weight = 450,
		-- weight = "Medium"
	}),
	font_size = 11,
	line_height = 1.1,
	-- color
	-- color_scheme = "Atelier Dune (base16)",
	-- color_scheme = "Decaf (base16)",
	-- color_scheme = "tokyonight-storm",
	color_scheme = "OceanicNext (base16)",
	-- color_scheme = "tokyonight-day",
	-- window
	window_frame = {
		font_size = 11,
	},
	hide_tab_bar_if_only_one_tab = true,
	-- tab_bar_at_bottom = true,
	window_padding = {
		left = 5,
		right = 5,
		top = 2,
		bottom = 2,
	},
}
