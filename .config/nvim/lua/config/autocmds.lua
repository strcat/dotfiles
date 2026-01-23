local function augroup(name)
	return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*neomutt-*", "*.txt", "*.markdown", "*.md", "*.asciidoc", "*.adoc" },
	-- pattern = { "*/tmp/neomutt-*", "*.md", "*.markdown", "*.txt" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en,de"
		-- vim.opt.spell = true
		-- vim.opt.spelllang = "de,en"
		vim.opt.spellfile = vim.fn.expand("~/.config/nvim/spell/en.utf-8.add")
		-- vim.cmd("so ~/.config/nvim/lua/plugins/txt/abolish.txt")
		vim.cmd("so ~/.config/nvim/macros/abolish.txt")
	end,
	-- command = "so ~/.config/nvim/lua/plugins/abolish.txt",
})
--
-- -- config for built-in undotree plugin
-- vim.cmd.packadd("nvim.undotree") -- load on startup
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "nvim-undotree",
--     callback = function()
--         vim.cmd.wincmd("H")
--         vim.api.nvim_win_set_width(0, 40)
--     end,
-- })

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "HopNextKey", { fg = "#ff9900", bold = true, ctermfg = 198, cterm = { bold = true } })
		vim.api.nvim_set_hl(0, "HopNextKey1", { fg = "#ff9900", bold = true, ctermfg = 198, cterm = { bold = true } })
		vim.api.nvim_set_hl(0, "HopNextKey2", { fg = "#ff9900", bold = true, ctermfg = 198, cterm = { bold = true } })
	end,
})

-- Show yanking for 200ms
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({
			on_visual = false,
			higroup = "IncSearch",
			timeout = 200,
		})
	end,
})

-- (Neo)Mutt/Slrn
vim.api.nvim_create_autocmd({ "BufRead" }, {
	pattern = { "*/tmp/neomutt-*", "*/.article", "*/.followup" },
	command = "so ~/.config/nvim/macros/MailNews.vim",
})

-- reload tmux after updating config
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*tmux.conf" },
	command = "execute 'silent !tmux source <afile> --silent'",
})
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "tmux.conf", ".tmux.conf" },
	callback = function()
		vim.lsp.start({
			name = "tmux",
			cmd = { "tmux-language-server" },
		})
	end,
})

-- -- Disable autoformat for C/CPP, LUA, ..
-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	pattern = { "cpp", "html", "css", "sh" },
-- 	callback = function()
-- 		vim.b.autoformat = false
-- 	end,
-- })

vim.api.nvim_create_autocmd("Filetype", {
	pattern = { "html", "shtml", "htm" },
	callback = function()
		vim.lsp.start({
			name = "superhtml",
			cmd = { "superhtml", "lsp" },
			root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
		})
	end,
})

-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	callback = function()
		local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
		if ok and cl then
			vim.wo.cursorline = true
			vim.api.nvim_win_del_var(0, "auto-cursorline")
		end
	end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
	callback = function()
		local cl = vim.wo.cursorline
		if cl then
			vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
			vim.wo.cursorline = false
		end
	end,
})

-- create directories when needed, when saving a file
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
	callback = function(event)
		local file = vim.loop.fs_realpath(event.match) or event.match

		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
		local backup = vim.fn.fnamemodify(file, ":p:~:h")
		backup = backup:gsub("[/\\]", "%%")
		vim.go.backupext = backup
	end,
})

-- make zsh files recognized as sh for bash-ls & treesitter
vim.filetype.add({
	extension = {
		zsh = "sh",
		sh = "sh", -- force sh-files with zsh-shebang to still get sh as filetype
	},
	filename = {
		[".zshrc"] = "sh",
		["zshaliases"] = "sh",
		["zshbinding"] = "sh",
		["zshexports"] = "sh",
		["zshfunctions"] = "sh",
		["zshfzf"] = "sh",
		["zshmisc"] = "sh",
		[".zshenv"] = "sh",
	},
})

-- OpenBSD developers use eight column tabs
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = {
		"/usr/ports/*",
		"/usr/src/*",
		"/usr/www/*",
		"/usr/xenocara/*",
	},
	callback = function()
		vim.opt.shiftwidth = 8
		vim.opt.tabstop = 8
		vim.opt.expandtab = false
	end,
})

-- 'Open file at the last position it was edited earlier',
vim.api.nvim_create_autocmd("BufReadPost", {
	-- group = misc_augroup,
	pattern = "*",
	command = 'silent! normal! g`"zv',
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
		"toggleterm",
		"neo-tree",
		"blink-tree",
		"gitsigns-blame",
		"AvanteAsk",
		"AvanteInput",
		"Trouble",
		-- "PlenaryTestPopup",
		-- "grug-far",
		-- "help",
		-- "lspinfo",
		-- "notify",
		-- "qf",
		-- "spectre_panel",
		-- "startuptime",
		-- "tsplayground",
		-- "neotest-output",
		-- "checkhealth",
		-- "neotest-summary",
		-- "neotest-output-panel",
		-- "dbout",
		-- "gitsigns.blame",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", {
			buffer = event.buf,
			silent = true,
			desc = "Quit buffer",
		})
	end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("man_unlisted"),
	pattern = { "man" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
	end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "text", "plaintex", "typst", "gitcommit", "markdown", "md" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- -- Disable `treesitter-context` for certain filetypes.
-- local disabled_filetypes = { "markdown", "help", "txt" }
-- local context_group = vim.api.nvim_create_augroup("TreesitterContextToggle", { clear = true })
-- vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
--   group = context_group,
--   callback = function()
--     local current_ft = vim.bo.filetype
--     if vim.tbl_contains(disabled_filetypes, current_ft) then
--       require("treesitter-context").disable()
--     else
--       require("treesitter-context").enable()
--     end
--   end,
-- })
