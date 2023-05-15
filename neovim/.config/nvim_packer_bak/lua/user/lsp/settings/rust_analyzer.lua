return {
	settings = {
		["rust-analyzer"] = {
			rustfmt = {
				rangeFormatting = {
					enable = true,
				},
			},
			cargo = {
				allFeatures = true,
			},
			check_on_save = {
				command = "clippy",
				extraArgs = {
					"--no-deps",
					"--",
					"--warn",
					"clippy::pedantic",
				},
			},
			workspace = {
				symbol = {
					search = {
						kind = "all_symbols",
					},
				},
			},
		},
	},
}
