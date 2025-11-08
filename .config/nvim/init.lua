require("config.autocmds")
require("config.keymaps")
require("config.options")

-- Set up the Lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Set up plugins
require("lazy").setup({
	require("plugins.cmp"),
	require("plugins.colorscheme"),
	require("plugins.formatting"),
	require("plugins.fzflua"),
	require("plugins.gitsigns"),
	require("plugins.image"),
	require("plugins.snacks"),
	require("plugins.lint"),
	require("plugins.lsp"),
	require("plugins.lualine"),
	require("plugins.luasnip"),
	require("plugins.markdown"),
	require("plugins.mdplus"),
	require("plugins.mini"),
	require("plugins.misc"),
	require("plugins.neoscroll"),
	require("plugins.noice"),
	require("plugins.none-ls"),
	require("plugins.nvim-tree"),
	require("plugins.telescope"),
	require("plugins.trouble"),
	require("plugins.abolish"),
	require("plugins.treesitter"),
	require("plugins.vim-tmux-navigator"),
	require("plugins.undo"),
	require("plugins.which-key"),
})
