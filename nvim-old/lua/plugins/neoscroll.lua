return {
	-- *** smooth scrolling
	"karb94/neoscroll.nvim",
	-- event = buffer_with_content_events,
	config = function()
		local neoscroll = require("neoscroll")
		-- additional/custom keybindings, why aren't PageUp/Down OOB? any reason why I shouldn't remap those too?
		-- default mappings: https://github.com/karb94/neoscroll.nvim/blob/master/lua/neoscroll/init.lua#L411-L424
		local keymap = {
			-- scroll full page:
			["<C-b>"] = function()
				neoscroll.ctrl_b({ duration = 350 })
			end, -- 450 default
			["<C-f>"] = function()
				neoscroll.ctrl_f({ duration = 350 })
			end, -- 450 default
			["<PageUp>"] = function()
				neoscroll.ctrl_b({ duration = 350 })
			end, -- not mapped by neoscroll
			["<PageDown>"] = function()
				neoscroll.ctrl_f({ duration = 350 })
			end, -- not mapped by neoscroll
			--
			-- scroll half page:
			-- ["<C-u>"]      = function() neoscroll.ctrl_u({ duration = 250 }) end, -- 250 default
			-- ["<C-d>"]      = function() neoscroll.ctrl_d({ duration = 250 }) end, -- 250 default

			-- scroll a "few" line(s):
			-- FYI benefit is # lines is relative to size of window (and if I resize the vim instance, it correctly adjusts on the fly with ratio below)
			-- TODO go back to using relative line count scroll instead of default 1 line?
			--    if so, I need to update <C-S-e> and <C-S-y> to use relative line count too
			["<C-y>"] = function()
				neoscroll.scroll(-0.1, { move_cursor = false, duration = 50 })
			end, -- 100 default
			["<C-e>"] = function()
				neoscroll.scroll(0.1, { move_cursor = false, duration = 50 })
			end, -- 100 default (feels slow)
			-- FYI love move_cursor param! allows me to use original C-e/y design and have a scrollunder variant:
			["<C-S-y>"] = function()
				neoscroll.scroll(-0.1, { move_cursor = true, duration = 50 })
			end, -- 100 default
			["<C-S-e>"] = function()
				neoscroll.scroll(0.1, { move_cursor = true, duration = 50 })
			end, -- 100 default (feels slow)
			-- FYI neoscroll is more than just about smooth scroll, it's a tool to design all sorts of scrolls

			--
			-- scroll cursor line to top/middle/bottom:
			-- 150 feels fine (even slow sometimes) for these, esp zz which often has a minimal move to make
			["zt"] = function()
				neoscroll.zt({ half_win_duration = 150 })
			end, -- 250 half_win_duration default
			["zz"] = function()
				neoscroll.zz({ half_win_duration = 150 })
			end, -- 250 half_win_duration default
			["zb"] = function()
				neoscroll.zb({ half_win_duration = 150 })
			end, -- 250 half_win_duration default, too slow when move is large (top line to bottom = 2x250 = 500ms)
		}
		local modes = { "n", "v", "x" }
		for key, func in pairs(keymap) do
			vim.keymap.set(modes, key, func)
		end
		neoscroll.setup({
			mappings = {
				-- FYI make sure you uncomment here if you comment out customizations above
				-- remove keys that you want to customize, else neoscroll will redefine them
				"<C-u>", -- 250 default works good
				"<C-d>", -- 250 default works good
				-- '<C-b>',
				-- '<C-f>',
				-- '<C-y>',
				-- '<C-e>',
				-- 'zt',
				-- 'zz',
				-- 'zb',
				-- 'G', -- I expect this to be jarring and would never wanna wait 250ms per page up/down!
				-- 'gg',
			},
			-- easing = "quartic", -- I think I prefer linear default
		})
	end,
}
