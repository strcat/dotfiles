-- plugin for fzf-lua fuzzy finder
return {
	"ibhagwan/fzf-lua",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local ok, fzf = pcall(require, "fzf-lua")
		local actions = require("fzf-lua.actions")
		if not ok then
			return
		end
		fzf.setup({
			defaults = {
				git_icons = false,
				file_icons = false,
				color_icons = false,
			},
      fzf_opts = {
					["--info"] = "default",
					["--layout"] = "reverse-list",
					["--header-first"] = false,
					["--color"] = "bg+:-1,fg+:blue,pointer:magenta,marker:magenta,prompt:gray,header:gray",
				},
			winopts = {
				border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				preview = {
					title = true,
					layout = "horizontal",
					width = 0.95,
					vertical = "up:75%",
				},
			},
			files = {
				formatter = "path.filename_first",
				git_icons = true,
				file_icons = true,
				prompt = "Files> ",
				no_header = true,
				cwd_header = true,
				cwd_prompt = true,
			},
			grep = {
				actions = {
					["ctrl-q"] = {
						fn = actions.file_edit_or_qf,
						prefix = "select-all+",
					},
				},
				prompt = "Rg❯ ",
				input_prompt = "Grep For❯ ",
				git_icons = true,
				no_header = true,
				no_header_i = true,
				cwd_header = false,
				cwd_prompt = false,
			},
			git = {
				status = {
					prompt = "Git Status> ",
					formatter = "path.filename_first",
					git_icons = true,
					no_header = true,
					cwd_header = false,
					cwd_prompt = false,
				},
			},
			diagnostics = {
				formatter = "path.filename_first",
				git_icons = true,
				prompt = "Diagnostics> ",
				no_header = true,
				cwd_header = false,
				cwd_prompt = false,
			},
		})
		fzf.register_ui_select()
	end,
}
