vim.pack.add({
  { src = 'https://github.com/nvim-mini/mini.ai', version = 'stable' },
  { src = 'https://github.com/nvim-mini/mini.align', version = 'stable' },
  { src = 'https://github.com/nvim-mini/mini.bracketed', version = 'stable' },
  { src = 'https://github.com/nvim-mini/mini.comment', version = 'stable' },
  { src = 'https://github.com/nvim-mini/mini.icons', version = 'stable' },
  { src = 'https://github.com/nvim-mini/mini.jump', version = 'stable' },
  { src = 'https://github.com/nvim-mini/mini.jump2d', version = 'stable' },
  { src = 'https://github.com/nvim-mini/mini.pairs', version = 'stable' },
  { src =	"https://github.com/nvim-mini/mini.clue", version = 'stable' },
  { src = 'https://github.com/nvim-mini/mini.surround', version = 'stable' },
  { src = 'https://github.com/nvim-mini/mini.statusline', version = 'stable' },
  { src = 'https://github.com/nvim-mini/mini.tabline', version = 'stable' },
  { src = 'https://github.com/nvim-mini/mini.trailspace', version = 'stable' }
  })

-- Better Around/Inside textobjects
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require("mini.ai").setup({ n_lines = 500 })
-- Add/delete/replace surroundings (brackets, quotes, etc.)
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
-- Surround actions
require("mini.surround").setup()
-- Icon provider
require("mini.icons").setup()
-- Minimal and fast tabline showing listed buffers
require("mini.tabline").setup()
-- Extend f, F, t, T to work on multiple lines.
require("mini.jump").setup()
-- Jump within visible lines via iterative label filtering
require("mini.jump2d").setup()
-- require("mini.files").setup()
-- Go forward/backward with square brackets
-- Buffer        - [B or B]
-- Comment block - [C or C]
require("mini.bracketed").setup()
-- Minimal and fast autopairs
require("mini.pairs").setup()
-- Pick anything
-- :Pick buffers, Files, ..
-- require("mini.pick").setup()
-- Align text interactively
require("mini.align").setup()
-- Tabline
require("mini.tabline").setup({})
-- Work with trailing whitespace
require("mini.trailspace").setup()
-- Comment lines
require("mini.comment").setup({})
-- -- "alternative" to which-key.. maybe..
-- require("mini.clue").setup({
-- 	triggers = {
-- 		{mode = "c", keys = "<c-r>"},
-- 		{mode = "i", keys = "<c-r>"},
-- 		{mode = "i", keys = "<c-x>"},
-- 		{mode = "n", keys = "<c-w>"},
-- 		{mode = "n", keys = "<leader>"},
-- 		-- {mode = "n", keys = "g"},
-- 		{mode = "n", keys = "z"},
-- 		{mode = "n", keys = [["]]},
-- 		{mode = "n", keys = [[']]},
-- 		{mode = "n", keys = [[`]]},
-- 		{mode = "x", keys = "<leader>"},
-- 		-- {mode = "x", keys = "g"},
-- 		{mode = "x", keys = "z"},
-- 		{mode = "x", keys = [["]]},
-- 		{mode = "x", keys = [[']]},
-- 		{mode = "x", keys = [[`]]},
-- 	},
-- 	clues = {
-- 		require("mini.clue").gen_clues.builtin_completion(),
-- 		require("mini.clue").gen_clues.g(),
-- 		require("mini.clue").gen_clues.marks(),
-- 		require("mini.clue").gen_clues.registers({
-- 			-- show_contents = true,
-- 		}),
-- 		require("mini.clue").gen_clues.windows({
-- 			submode_move = true,
-- 			submode_navigate = true,
-- 			submode_resize = true,
-- 		}),
-- 		require("mini.clue").gen_clues.z(),
-- 	},
-- 	window = {
-- 		config = {
-- 			width = math.floor(vim.o.columns / 3),
-- 			anchor = "SW",
--       border = 'double',
-- 			row = "auto",
-- 			col = "auto",
-- 		},
-- 		delay = 0,
-- 	},
-- })

-- Keymaps
vim.keymap.set("n", "<leader>ft", "<cmd>lua MiniTrailspace.trim()<CR>", { desc = "Trim whitespaces" })
