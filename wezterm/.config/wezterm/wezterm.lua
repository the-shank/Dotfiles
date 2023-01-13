local wezterm = require("wezterm")

return {
	font = wezterm.font("Iosevka Nerd Font", {
        -- weight = "Regular"
        weight = "Medium"
    }),
    font_size = 12,
    color_scheme = "nordfox",
    window_frame = {
        font_size = 11,
    },
    hide_tab_bar_if_only_one_tab = true,
	-- tab_bar_at_bottom = true,
	window_padding = {
		left = 1,
		right = 1,
		top = 1,
		bottom = 1,
	},
}
