return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		{ "tsakirist/telescope-lazy.nvim" },
		{ "benfowler/telescope-luasnip.nvim" },
		-- { "debugloop/telescope-undo.nvim" },
		{ "crispgm/telescope-heading.nvim" },
		{ "jvgrootveld/telescope-zoxide" },
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-telescope/telescope-frecency.nvim" },
	},
	config = function()
		local actions = require("telescope.actions")
		require("telescope").setup({
			-- You can put your default mappings / updates / etc. in here
			--  All the info you're looking for is in `:help telescope.setup()`
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
				frecency = {
					db_safe_mode = false,
					ignore_patterns = { "*.git/*", "*/tmp/*", "*/bin/*", "*/build/*" },
				},
			},
			pickers = {},
			defaults = {
				mappings = {
					i = {
						-- Mapping <Esc> to quit in insert mode
						["<esc>"] = actions.close,
						-- Mapping <C-u> to clear prompt
						["<C-u>"] = false,
					},
				},
			},
		})
		-- able Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "lazy")
		pcall(require("telescope").load_extension, "luasnip")
		pcall(require("telescope").load_extension, "neoclip")
		-- pcall(require("telescope").load_extension, "undo")
		pcall(require("telescope").load_extension, "heading")
		pcall(require("telescope").load_extension, "ui-select")
		pcall(require("telescope").load_extension, "frecency")
		pcall(require("telescope").load_extension, "zoxide")
	end,
}
