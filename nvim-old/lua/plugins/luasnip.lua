-- return {
-- 	'L3MON4D3/LuaSnip',
-- 	dependencies = { "rafamadriz/friendly-snippets" },
-- 	-- version = "v2.1.1",
-- 	build = "make install_jsregexp",
-- 	init = function()
-- 		require("luasnip.loaders.from_vscode").lazy_load()
-- 		require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
-- 	end,
-- }

return {
	"rafamadriz/friendly-snippets",
	{
		"L3MON4D3/LuaSnip",
		config = function()
			-- luasnip
			local luasnip = require("luasnip")
			-- load custom snippets first
			require("luasnip.loaders.from_vscode").load({ paths = { "./lua/snippets" } })
			-- externally provided snippets
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_snipmate").lazy_load()
			luasnip.filetype_extend("all", { "_" })
		end,
	},
}
