return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- local capabilities = require("blink.cmp").get_lsp_capabilities()
		-- require("lspconfig").lua_ls.setup({ capabilities = capabilities })
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})
					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end
			end,
		})
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
		local servers = {
			html = { filetypes = { "html", "twig", "hbs" } },
			cssls = {},
			yamlls = {},
			harper_ls = {
				enabled = true,
				filetypes = { "markdown", "mail", "plaintext", "html" },
				settings = {
					["harper-ls"] = {
						userDictPath = "~/github/dotfiles-latest/neovim/neobean/spell/en.utf-8.add",
						linters = {
							ToDoHyphen = false,
							SentenceCapitalization = true,
							SpellCheck = true,
							AvoidCurses = false,
						},
						isolateEnglish = true,
						markdown = {
							-- [ignores this part]()
							-- [[ also ignores my marksman links ]]
							IgnoreLinkTitle = true,
						},
					},
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = {
								"${3rd}/luv/library",
								unpack(vim.api.nvim_get_runtime_file("", true)),
							},
						},
						diagnostics = { disable = { "missing-fields" } },
						format = {
							enable = false,
						},
					},
				},
			},
		}
		require("mason").setup()
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua", -- Used to format Lua code
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
-- return {
--     -- completion system and main lsp setup
--     "neovim/nvim-lspconfig",
--     dependencies = {
--         "williamboman/mason.nvim",
--         "williamboman/mason-lspconfig.nvim",
--         "saghen/blink.cmp",
--     },
--     config = function()
--         -- extend capabilities of nvim in lsp completion
--         local capabilities = require("blink.cmp").get_lsp_capabilities()
--         local border = "single"
--
--         -- set borders
--         vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
--             vim.lsp.handlers.hover, { border = border }
--         )
--         vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
--             vim.lsp.handlers.signature_help, { border = border }
--         )
--         vim.diagnostic.config({ float={ border = border } })
--         require("mason").setup({ ui = { border = border } })
--
--         -- setup lsp
--         require("mason-lspconfig").setup({
--             -- ensure_installed = {
--             --     "pylsp",
--             --     "clangd",
--             --     "bashls",
--             --     "taplo",
--             --     "jsonls",
--             --     "yamlls",
--             -- },
--             -- functions to call on start of lsp
--             -- basically auto setup of lsp
--             handlers = {
--                 -- default handler
--                 function(server_name)
--                     require("lspconfig")[server_name].setup({
--                         capabilities = capabilities,
--                     })
--                 end,
--
--                 ["pylsp"] = function()
--                     require("lspconfig")["pylsp"].setup({
--                         capabilities = capabilities,
--                         settings = {
--                             pylsp = {
--                                 plugins = {
--                                     -- use black as default formatter
--                                     yapf = { enabled = false },
--                                     autopep8 = { enabled = false },
--                                     black = { enabled = true },
--                                     pycodestyle = {
--                                         enabled = true,
--                                         ignore = { "E203", "E701", "W503" },
--                                         maxLineLength = 88
--                                     }
--                                 }
--                             },
--                         },
--                     })
--                 end,
--
--                 ["texlab"] = function()
--                     require("lspconfig")["texlab"].setup({
--                         capabilities = capabilities,
--                         settings = {
--                             texlab = {
--                                 build = {
--                                     executable = "latexmk",
--                                     args = {
--                                         "-lualatex",
--                                         "-interaction=nonstopmode",
--                                         "-outdir=build",
--                                     },
--                                     onSave = true,
--                                 },
--                             }
--                         }
--                     })
--                 end,
--
--                 ["bashls"] = function()
--                     require("lspconfig")["bashls"].setup({
--                         capabilities = capabilities,
--                         settings = {
--                             bashIde = {
--                                 shellcheckArguments = {
--                                     "--exclude=SC1090,SC1091,SC2076,SC2164"
--                                 },
--                             }
--                         }
--                     })
--                 end,
--
--                 ["clangd"] = function()
--                     local style = "llvm"
--                     require("lspconfig")["clangd"].setup({
--                         capabilities = capabilities,
--                         cmd = {
--                             "clangd",
--                             "--fallback-style="..style,
--                         }
--                     })
--                 end,
--             },
--         })
--     end,
-- }
--
