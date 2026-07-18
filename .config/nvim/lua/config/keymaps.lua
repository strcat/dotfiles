local set = vim.keymap.set

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Disable the spacebar key's default behavior in Normal and Visual modes
set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- quick save/quit
set({ "n", "i" }, "<C-s>", "<cmd>w<CR><ESC>")
set("n", "<leader>qq", "<cmd>q<CR>", { desc = "quit" })
set("n", "<leader>qw", "<cmd>wq<CR>", { desc = "Save and Quit" })
set("n", "<leader>q!", "<cmd>q!<CR>", { desc = "Quit without saving" })

-- Escape insertmode
set("i", "jj", "<ESC>")

-- buffers
set("n", "<leader>bd", "<cmd>:bd<CR>", { desc = "Close current buffer" })

-- vim.pack
set("n", "<leader>pu", function() vim.pack.update() end, { desc = "vim.pack: Update plugins" })

-- Standard template for my tutorials
set(
	"n",
	"<leader>ph",
	"<cmd>!pandoc --highlight-style=kate --standalone --embed-resource -c ~/homepage/eigenes/neu/new.css -A ~/homepage/eigenes/neu/footer.html --toc %:p -o %:p:r.html<CR>",
	{ desc = "Pandoc" }
)

-- clear search highlights
set("n", "<leader>oh", "<cmd>nohl<CR>", { desc = "Clear search highlights" })

-- better indenting
set("v", "<", "<gv")
set("v", ">", ">gv")

-- commenting
set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- yank'n'stuff
set("n", "<leader>yf", "<cmd>%y+<CR>", { desc = "Copy contents of current file to clipboard" })
set("n", "<leader>yp", '<cmd>let @+ = expand("%:t")<CR>', { desc = "Yank filepath to clipboard" })

-- half page up/down, search, .. with centering cursor
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

-- leave the cursor right there!
set("n", "p", function()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	vim.cmd("put")
	vim.api.nvim_win_set_cursor(0, { row + 1, col })
end)
