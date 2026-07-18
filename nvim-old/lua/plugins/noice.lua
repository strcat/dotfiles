return {
	"folke/noice.nvim",
	dependencies = {
		"rcarriga/nvim-notify",
	},
	lazy = false,
	config = function()
		require("noice").setup({
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = false, -- use a classic bottom cmdline for search
				command_palette = false, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
			routes = {
				{
					view = "notify",
					filter = { event = "msg_showmode" },
				},
			},
			cmdline = {
				view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
				format = {
					cmdline = { pattern = "^:", icon = "▷", lang = "vim", title = "" },
				},
			},
			views = {
				cmdline_popup = {
					position = {
						-- row = 5,
						-- col = "50%",
						row = "60%",
						col = "50%",
					},
					size = {
						width = 60,
						height = "auto",
					},
				},
				popupmenu = {
					relative = "editor",
					position = {
						-- row = 9,
						row = "80%",
						col = "50%",
					},
					size = {
						width = 60,
						height = 10,
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					win_options = {
						winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
					},
				},
			},
			-- views = {
			-- 	cmdline_popup = {
			-- 		size = {
			-- 			height = "auto",
			-- 			width = "90%",
			-- 		},
			-- 		position = {
			-- 			row = "90%",
			-- 			col = "50%",
			-- 		},
			-- 		border = {
			-- 			style = "single",
			-- 		},
			-- 	},
			-- },
		})
	end,
}
