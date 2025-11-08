return {
	{
		"sontungexpt/url-open",
		event = "VeryLazy",
		cmd = "URLOpenUnderCursor",
		config = function()
			local status_ok, url_open = pcall(require, "url-open")
			if not status_ok then
				return
			end
			url_open.setup({
				extra_patterns = {
					-- Markdown
					{ pattern = "<([%a%-]*:[^%s]*)>" },
					-- Org Mode
					{ pattern = "%[%[(.*)%]%[.*%]%]" },
				},
				deep_pattern = true,
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
		lazy = true,
		event = "VeryLazy",
	},
}
