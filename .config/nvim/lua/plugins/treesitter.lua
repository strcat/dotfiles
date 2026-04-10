return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		-- show the current context of the cursor
		{ "nvim-treesitter/nvim-treesitter-context" },
		-- setting the commentstring based on the cursor location in a filetypes
		{ "JoosepAlviste/nvim-ts-context-commentstring" },
	},
}
