return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		-- Documenting with which-key
		require("which-key").add({
			{ "<leader>b", group = "Buffer" },
			{ "<leader>c", group = "Code" },
			{ "<leader>l", group = "LSP" },
			{ "<leader>m", group = "Markdown" },
			{ "<leader>f", group = "File" },
			{ "<leader>g", group = "Git" },
			{ "<leader>p", group = "Pandoc" },
			{ "<leader>o", group = "Other" },
			-- { "<leader>m", group = "Format or Linting" },
			{ "<leader>r", group = "Rename" },
			{ "<leader>s", group = "Search" },
			{ "<leader>t", group = "Telescope" },
			{ "<leader>u", group = "Buffers" },
			{ "<leader>q", group = "Quit" },
			{ "<leader>w", group = "Wins" },
		})
	end,
	opts = {
		preset = "classic",
		-- modes = {
		-- 	x = false,
		-- },
		win = {
			border = "none",
			-- padding = { 1, 3 },
		},
		icons = {
			rules = false,
			keys = {
				Up = " ",
				Down = " ",
				Left = " ",
				Right = " ",
				C = "ctrl ",
				M = "meta ",
				S = "shft ",
				CR = "retr ",
				Esc = "esc ",
				ScrollWheelDown = "󱕐 ",
				ScrollWheelUp = "󱕑 ",
				NL = "newl ",
				BS = "bks ",
				Space = "spc ",
				Tab = "tab ",
			},
		},
	},
}
