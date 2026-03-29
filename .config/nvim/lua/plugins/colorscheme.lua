local function enable_transparency()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
end
return {
	{
		"thesimonho/kanagawa-paper.nvim",
		lazy = false,
		priority = 1000,
		config = function()
	require("kanagawa-paper").setup({
		transparent = true,
		overrides = function(colors)
			local theme = colors.theme
			local background = "#000000"
			local foreground_dim = "#333333"
			local red = "#d3d3d3"
			local blue = "#fafafa"
			return {
				["@string.special.url"] = { undercurl = false },
				Underlined = { fg = blue },
				Normal = { fg = red },
				LineNr = { fg = foreground_dim },
				FloatBorder = { bg = background, fg = theme.ui.fg },
				WinSeparator = { fg = foreground_dim },
				BufferLineSeparator = { fg = foreground_dim },
				VertSplit = { fg = foreground_dim },
				FloatTitle = { bg = background },
				Folded = { fg = "none", bg = "none" },
				MiniTablineCurrent = { bg = "#3b4261", fg = "#c8d3f5" },
				MiniTablineFill = { bg = "#1b1d2b" },
				MiniTablineHidden = { bg = "#1e2030", fg = "#737aa2" },
				MiniTablineModifiedCurrent = { bg = "#3b4261", fg = "#ffc777" },
				MiniTablineModifiedHidden = { bg = "#1e2030", fg = "#bd9664" },
				MiniTablineModifiedVisible = { bg = "#1e2030", fg = "#ffc777" },
				MiniTablineTabpagesection = { bg = "#1e2030", fg = "NONE" },
				MiniTablineVisible = { bg = "#1e2030", fg = "#c8d3f5" },
				WhichKeyNormal = { bg = "#1f2335" },
				TelescopeNormal = { bg = "#24273a" },
				TelescopeBorder = { fg = "#8aadf4", bg = "#24273a" },
				TelescopePromptNormal = { bg = "#24273a" },
				TelescopePromptBorder = { fg = "#8aadf4", bg = "#24273a" },
				TelescopeResultsNormal = { bg = "#24273a" },
				TelescopeResultsBorder = { fg = "#8aadf4", bg = "#24273a" },
				TelescopePreviewNormal = { bg = "#24273a" },
				TelescopePreviewBorder = { fg = "#8aadf4", bg = "#24273a" },
				TelescopeTitle = { fg = "#c6a0f6", bg = "#24273a" },
				TelescopePromptTitle = { fg = "#c6a0f6", bg = "#24273a" },
				TelescopeResultsTitle = { fg = "#c6a0f6", bg = "#24273a" },
				TelescopePreviewTitle = { fg = "#c6a0f6", bg = "#24273a" },
			}
		end,
		enable_transparency(),
	})
		end,
	},
	{
		"ankushbhagats/pastel.nvim",
		config = function()
	require("pastel").setup({
		style = {
			italic = true,
			transparent = true,
			dynamic_statusline = true,
		},
		highlights = {
			global = function(hl)
				hl.Normal.bg = "#11111b"
			end,
		},
	})
	vim.cmd("colorscheme pasteldark")
		end,
	},
}
