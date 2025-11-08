return { -- Collection of various small independent plugins/modules
	"nvim-mini/mini.nvim",
	-- "echasnovski/mini.nvim",
	config = function()
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
    -- Visualize and work with indent scope
    require("mini.indentscope").setup()
		-- Minimal and fast autopairs
		require("mini.pairs").setup()
		-- Pick anything
		-- :Pick buffers, Files, ..
		require("mini.pick").setup()
		-- Move any selection in any direction
		require("mini.move").setup({
			mappings = {
				left = "H",
				right = "L",
				down = "J",
				up = "K",
				line_left = "H",
				line_right = "L",
				line_down = "J",
				line_up = "K",
			},
		})
		-- Align text interactively
		require("mini.align").setup()
		-- Tabline
		require("mini.tabline").setup({})
		-- Work with trailing whitespace
		require("mini.trailspace").setup()
		-- Comment lines
		require("mini.comment").setup({
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
				end,
			},
		})
		-- Highlight patterns in text
		require("mini.hipatterns").setup({
			highlighters = {
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
				hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
			},
		})
	end,
}
