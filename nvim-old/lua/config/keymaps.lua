local set = vim.keymap.set

set("n", "cv", function()
	local lines_enabled = not vim.diagnostic.config().virtual_lines
	vim.diagnostic.config({
		virtual_lines = lines_enabled,
		virtual_text = not lines_enabled,
	})
end, { noremap = true, silent = true, desc = "Change diagnostics style" })

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

-- Toggleterm
-- set({ "n", "i" }, "<C-i>", "<cmd>:ToggleTerm<CR>", { desc = "Toggle Terminal" })

-- Escape insertmode
set("i", "jj", "<ESC>")

-- buffers
set("n", "<leader>bd", "<cmd>:bd<CR>", { desc = "Close current buffer" })
-- set("n", "<leader>bb", "<cmd>e #<CR>", { desc = "Switch to other buffer" })

-- Lazy and Mason
set("n", "<leader>LL", "<cmd>Lazy check<CR>", { desc = "Lazy" })
set("n", "<leader>LM", "<cmd>Mason<CR>", { desc = "Mason" })
set(
	"n",
	"<leader>ph",
	"<cmd>!pandoc --highlight-style=kate --standalone --embed-resource -c ~/homepage/eigenes/neu/new.css -A ~/homepage/eigenes/neu/footer.html --toc %:p -o %:p:r.html<CR>",
	{ desc = "Pandoc" }
)
-- set("n", "<leader>ph", "<cmd>!pandoc -t beamer -f markdown -o %.pdf % && open %.pdf<cr>")
-- pandoc %:p -o %:p:r.html'<CR>" , "html"},

-- clear search highlights
set("n", "<leader>oh", "<cmd>nohl<CR>", { desc = "Clear search highlights" })

-- https://github.com/sontungexpt/url-open
set("n", "<leader>gx", "<esc>:URLOpenUnderCursor<cr>")

-- better indenting
set("v", "<", "<gv")
set("v", ">", ">gv")

-- commenting
set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- empty lines
-- NOTE: since nvim 0.11 its already implementated with [<space> or <space>]
-- set("n", "gO", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", { desc = "Empty Line Above" })
-- set("n", "go", "<Cmd>call append(line('.'), repeat([''], v:count1))<CR>", { desc = "Empty Line Below" })

-- yank'n'stuff
set("n", "<leader>yf", "<cmd>%y+<CR>", { desc = "Copy contents of current file to clipboard" })
set("n", "<leader>yp", '<cmd>let @+ = expand("%:t")<CR>', { desc = "Yank filepath to clipboard" })

-- search keyword
local searching_brave = function()
	vim.fn.system({ "xdg-open", "https://search.brave.com/search?q=" .. vim.fn.expand("<cword>") })
end
set("n", "gX", searching_brave, { noremap = true, silent = true, desc = "Search Current Word on Brave Search" })

-- half page up/down, search, .. with centering cursor
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

-- Fileoperations
set("n", "<leader>ft", "<cmd>lua MiniTrailspace.trim()<CR>", { desc = "Trim whitespaces" })
set("n", "<leader>fn", "<esc>:e ", { desc = "New file" })

-- Toggle diagnostics
set("n", "<leader>ld", function()
	-- If we find a floating window, close it.
	local found_float = false
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(win).relative ~= "" then
			vim.api.nvim_win_close(win, true)
			found_float = true
		end
	end
	if found_float then
		return
	end
	vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
end, { desc = "Toggle Diagnostics" })

-- markview
set("n", "<leader>mt", ":Markview toggleAll<CR>", { desc = "Toggle all chunks" })

-- FzfLua
set("n", "<leader>tg", ":FzfLua live_grep_native<CR>", { desc = "FzfLua livegrep" })
set("n", "<leader>tm", ":FzfLua marks<CR>", { desc = "FzfLua marks" })
set("n", "<leader>ff", ":FzfLua files<CR>", { desc = "FzfLua Files" })
set("n", "<leader>tr", ":FzfLua resume<CR>", { desc = "FzfLua resume" })
set("n", "<leader>tF", function()
	require("fzf-lua").files({ cwd = "~" })
end, { desc = "Files in $HOME" })
-- set("n", "<leader>tF", function() require("fzf-lua").files({ cwd = "~" }) end, desc = "foobar"}
set("n", "=z", ":FzfLua spell_suggest<CR>", { desc = "Spelling Suggestion (FZF)" })

-- Telescope
set("n", "<leader>mh", ":Telescope heading<CR>", { desc = "Headings" })
set("n", "<leader>tn", "<cmd>Telescope neoclip<CR>", { desc = "Telescope NeoClip" })
set("n", "<leader>tl", "<cmd>Telescope luasnip<CR>", { desc = "Telescope Luasnip" })
set("n", "<leader><leader>", "<cmd>Telescope frecency<CR>", { desc = "Telescope frecency" })
set("n", "<leader>,", ":FzfLua buffers<CR>", { desc = "FzfLua Buffer" })
set("n", "<leader>tc", ":Telescope git_commits<CR>", { desc = "Telescope Gitcommits" })
set("n", "<leader>li", ":Telescope lsp_implementations<CR>", { desc = "LSP implementations" })
set("n", "<leader>lR", ":Telescope lsp_references<CR>", { desc = "LSP References" })
set("n", "<leader>lD", ":Telescope lsp_type_definitions<CR>", { desc = "LSP Type Definitions" })
set("n", "<leader>th", ":Telescope help_tags<CR>", { desc = "Telescope Helptags" })
set("n", "<leader>tk", ":Telescope keymaps<CR>", { desc = "Telescope Keymaps" })
set("n", "<leader>ts", ":Telescope spell_suggest<CR>", { desc = "Telescope spellsuggest" })
-- set("n", "<leader>tu", ":Telescope undo<CR>", { desc = "Telescope Undo" })
set("n", "<leader>tz", ":Telescope zoxide list<CR>", { desc = "Telescope Zoxide " })
-- set("n", "<leader>tL", ":Telescope lazy<CR>", { desc = "Telescope lazy" })

-- Undotree
set("n", "<leader>tu", ":Atone toggle<CR>", { desc = "Undo" })

-- Filemanager
set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Filemanager" })

-- leave the cursor right there!
set("n", "p", function()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	vim.cmd("put")
	vim.api.nvim_win_set_cursor(0, { row + 1, col })
end)

local terminal_state = {
  buf = nil,
  win = nil,
  is_open = false
}

local function FloatingTerminal()
  -- If terminal is already open, close it (toggle behavior)
  if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
    return
  end

  -- Create buffer if it doesn't exist or is invalid
  if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
    terminal_state.buf = vim.api.nvim_create_buf(false, true)
    -- Set buffer options for better terminal experience
    vim.api.nvim_buf_set_option(terminal_state.buf, 'bufhidden', 'hide')
  end

  -- Calculate window dimensions
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create the floating window
  terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  -- Set transparency for the floating window
  vim.api.nvim_win_set_option(terminal_state.win, 'winblend', 0)

  -- Set transparent background for the window
  vim.api.nvim_win_set_option(terminal_state.win, 'winhighlight',
    'Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder')

  -- Define highlight groups for transparency
  vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none", })

  -- Start terminal if not already running
  local has_terminal = false
  local lines = vim.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, false)
  for _, line in ipairs(lines) do
    if line ~= "" then
      has_terminal = true
      break
    end
  end

  if not has_terminal then
    vim.fn.termopen(os.getenv("SHELL"))
  end

  terminal_state.is_open = true
  vim.cmd("startinsert")

  -- Set up auto-close on buffer leave 
  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = terminal_state.buf,
    callback = function()
      if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
      end
    end,
    once = true
  })
end

-- Function to explicitly close the terminal
local function CloseFloatingTerminal()
  if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
  end
end

-- Key mappings
vim.keymap.set("n", "<leader>ot", FloatingTerminal, { noremap = true, silent = true, desc = "Toggle floating terminal" })
vim.keymap.set("t", "<Esc>", function()
  if terminal_state.is_open then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
  end
end, { noremap = true, silent = true, desc = "Close floating terminal from terminal mode" })

-- Auto-close terminal when process exits
vim.api.nvim_create_autocmd("TermClose", {
  group = augroup,
  callback = function()
    if vim.v.event.status == 0 then
      vim.api.nvim_buf_delete(0, {})
    end
  end,
})

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})
