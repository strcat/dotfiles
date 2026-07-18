return {
	{
		"folke/trouble.nvim",
		-- dependencies = { "rachartier/tiny-devicons-auto-colors.nvim" },
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics open<cr>",
				desc = "Diagnostics",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics open filter.buf=0<cr>",
				desc = "Buffer Diagnostics",
			},
			{
				"<leader>xs",
				"<cmd>Trouble symbols open focus=false<cr>",
				desc = "Symbols",
			},
			{
				"<leader>xl",
				"<cmd>Trouble lsp open focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ...",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist open<cr>",
				desc = "Location List",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist open<cr>",
				desc = "Quickfix List",
			},
		},
		opts = {
			focus = true,
			throttle = {
				preview = { debounce = false },
			},
			action_keys = {
				previous = { "k", "<Up>" },
				next = { "j", "<Down>" },
			},
		},
	},
}
