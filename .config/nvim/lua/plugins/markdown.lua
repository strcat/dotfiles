return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
	opts = {
		link = {
			enabled = true,
			footnote = {
				superscript = true,
				prefix = "",
				suffix = "",
			},
			image = "󰥶 ",
			email = "󰀓 ",
			hyperlink = "󰌹 ",
			highlight = "RenderMarkdownLink",
			wiki = { icon = "󱗖 ", highlight = "RenderMarkdownWikiLink" },
		},
		latex = {
			enabled = false,
		},
		code = {
			enabled = true,
			sign = "language",
			style = "full",
			position = "left",
			language_pad = 0,
			language_name = true,
			disable_background = { "diff" },
			width = "block",
			left_margin = 0,
			left_pad = 2,
			right_pad = 2,
			min_width = 0,
			border = "thin",
			above = "▄",
			below = "▀",
			highlight = "RenderMarkdownCode",
			highlight_inline = "RenderMarkdownCodeInline",
			highlight_language = nil,
		},
	},
}
