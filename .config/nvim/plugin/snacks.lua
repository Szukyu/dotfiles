vim.pack.add({ "https://github.com/folke/snacks.nvim" })

require("snacks").setup({
	scroll = {
		animate = {
			duration = { step = 6, total = 140 },
			easing = "linear",
		},
	},
	image = {
		enabled = false, -- NOTE: Disable snacks.image
		formats = {}, -- HACK: Disable image preview for other modules like picker
	},
	picker = {
		layout = {
			layout = {
				box = "horizontal",
				width = 0.9,
				min_width = 120,
				height = 0.9,
				{
					box = "vertical",
					border = "single",
					title = "{title}",
					{ win = "input", height = 1, border = "bottom" },
					{ win = "list", border = "none" },
				},
				{
					win = "preview",
					title = "{preview}",
					width = 0.5,
					border = "single",
					wo = {
						cursorcolumn = false,
					},
				},
			},
		},
		win = {
			input = {
				keys = {
					-- ["<Esc>"] = { "close", mode = { "n", "i" } },
					["<c-y>"] = { "confirm", mode = { "n", "i" } },
				},
				wo = {
					cursorlineopt = "line",
				},
			},
		},
		sources = {
			explorer = {
				hidden = true,
				layout = {
					layout = {
						backdrop = false,
						width = 55,
						min_width = 55,
						height = 0,
						position = "right",
						border = "none",
						box = "vertical",
						-- {
						-- 	win = "input",
						-- 	height = 1,
						-- 	border = "single",
						-- 	title = "{title} {live} {flags}",
						-- 	title_pos = "center",
						-- },
						{ win = "list", border = "none" },
						-- { win = "preview", title = "{preview}", height = 0.4, border = "top" },
					},
				},
			},
			spelling = {
				layout = {
					layout = {
						box = "horizontal",
						width = 0.6,
						min_width = 60,
						height = 0.8,
						{
							box = "vertical",
							border = "single",
							title = "{title}",
							{ win = "input", height = 1, border = "bottom" },
							{ win = "list", border = "none" },
						},
					},
				},
			},
		},
	},
	indent = {
		animate = {
			enabled = false,
		},
	},
})
