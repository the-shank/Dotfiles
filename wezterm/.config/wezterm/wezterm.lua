local wezterm = require("wezterm")

return {
	-- font
	-- font = wezterm.font("Iosevka Nerd Font", {
	font = wezterm.font("NotoSansMono Nerd Font", {
		weight = "Regular",
		-- weight = "Medium"
	}),
	font_size = 12,
	-- line_height = 1.1,
	-- color
	color_scheme = "Decaf (base16)",
	-- color_scheme = "tokyonight-storm",
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
