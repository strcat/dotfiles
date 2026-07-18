-- local opt, o, g, fn = vim.opt, vim.o, vim.g, vim.fn
local g   = vim.g
local opt = vim.opt
local o   = vim.o

o.termguicolors = true      -- Enable true color support
o.clipboard = "unnamedplus" -- sync with system clipboard
o.wrap = true               -- Enable line wrapping
-- o.wrap = false              -- dont display lines as one long line
o.textwidth = 80            -- Textwidth
o.linebreak = true          -- companion to wrap don't split word
o.breakindent = true        -- Enable break indent
o.showmode = false          -- we don't need to see things like -- INSERT -- anymore
o.tabstop = 2               -- insert n spaces for a tab
o.softtabstop = 2
o.expandtab = true

o.splitbelow = true         -- better splitting
o.splitright = true

o.inccommand = "split"      -- Preview substitutions live, as you type!
o.ignorecase = true         -- Case-insensitive searching UNLESS \C or one
o.smartcase = true          -- or more capital letters in the search term

o.signcolumn = "yes"        -- Enable the sign column to prevent the screen from jumping
o.cursorline = true         -- Enable cursor line highlight
o.number = true             -- numbers and relativenumbers
o.relativenumber = true
o.scrolloff = 8             -- Always keep 8 lines above/below cursor unless at start/end of file
o.undofile = true           -- Save undo history (needed vor https://github.com/debugloop/telescope-undo.nvim)
o.wildignore = -- See :h wildignore
	"*.pyc,*.o,*.class,*.obj,*.svn,*.swp,*.swo,*.exe,*.dll,*.so,*.dylib,*.jar,*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.tar.zst,*.tar.lz,*.hg,*.DS_Store,*.min.*,node_modules"
