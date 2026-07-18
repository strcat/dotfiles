-- local formatting = require("null-ls.builtins._meta.formatting")
-- local cmp = require "cmp"
return {
	-- auto completion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"tamago324/cmp-zsh",
			"hrsh7th/cmp-nvim-lua",
			"onsails/lspkind.nvim",
		},
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")
			local has_words_before = function()
				-- local unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end
			return {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = {
						border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
						scrollbar = "║",
					},
					documentation = {
						border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
						scrollbar = "║",
					},
				},
				mapping = {
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					-- ["<c-space>"] = cmp.mapping:complete(),
					["<C-e>"] = cmp.mapping.abort(),
					-- ["<C-Space>"] = cmp.mapping.confirm({ select = true }),
					["<CR>"] = cmp.mapping.confirm({ select = true }),

					-- super-tab completion
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
				},
				-- mapping = cmp.mapping.preset.insert({
				--   ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
				--   ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				--   ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
				--   ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				--   ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
				--   ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
				--   ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				--   ["<C-e>"] = cmp.mapping({
				--     i = cmp.mapping.abort(),
				--     c = cmp.mapping.close(),
				--   }),
				--   -- Accept currently selected item. If none selected, `select` first item.
				--   -- Set `select` to `false` to only confirm explicitly selected items.
				--   ["<CR>"] = cmp.mapping.confirm({ select = true }),
				-- }),

				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 1000 },
					{ name = "luasnip", priority = 750 },
					-- { name = "spell", priority = 500 },
					{ name = "path", priority = 500 },
					{ name = "buffer", priority = 250 },
					{ name = "nvim_lua" },
					-- { name = "plugins" },
				}),
				sorting = {
					comparators = {
						cmp.config.compare.exact,
						cmp.config.compare.offset,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						cmp.config.compare.locality,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
				preselect = cmp.PreselectMode.Item,
				formatting = {
					format = lspkind.cmp_format({
						with_text = false,
						menu = {
							buffer = "(Buffer)",
							luasnip = "(Snippet)",
							nvim_lsp = "(LSP)",
							nvim_lua = "(Lua)",
							path = "(Path)",
							spell = "(Spell)",
						},
					}),
				},
			}
		end,
	},
}
