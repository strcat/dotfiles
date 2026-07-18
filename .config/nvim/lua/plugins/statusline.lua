require('mini.statusline').setup({
    use_icons = true,
    content = {
        active = function()
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local git = MiniStatusline.section_git({ trunc_width = 40 })
            local diff = MiniStatusline.section_diff({ trunc_width = 80 })
            local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 60 })
            local lsp = MiniStatusline.section_lsp({ trunc_width = 40 })
            local filename = MiniStatusline.section_filename({ trunc_width = 140 })

            local function section_filetype(args)
                if MiniStatusline.is_truncated(args.trunc_width) or vim.bo.filetype == '' or vim.bo.buftype ~= '' then
                    return ''
                end
                local ok, icons = pcall(require, 'mini.icons')
                local icon = ok and select(1, icons.get('filetype', vim.bo.filetype)) or ''
                return string.format('%s %s│', icon, vim.bo.filetype)
            end

            local function section_lsp_clients(args)
                if MiniStatusline.is_truncated(args.trunc_width) then
                    return ''
                end
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if not clients or #clients == 0 then
                    return ''
                end
                local names = vim.tbl_map(function(c)
                    return c.name
                end, clients)
                return string.format(' %s', table.concat(names, ', '))
            end

            local function section_searchcount(args)
                if vim.v.hlsearch == 0 then
                    return ''
                end
                local ok, s = pcall(vim.fn.searchcount, { recompute = true })
                if not ok or s.current == nil or s.total == 0 then
                    return ''
                end
                local icon = MiniStatusline.is_truncated(args.trunc_width) and '' or ' '
                if s.incomplete == 1 then
                    return icon .. '?/?│'
                end
                local fmt = '>%d'
                local cur = s.current > s.maxcount and fmt:format(s.maxcount) or s.current
                local tot = s.total > s.maxcount and fmt:format(s.maxcount) or s.total
                return ('%s%s/%s│'):format(icon, cur, tot)
            end

            local function section_location(args)
                return MiniStatusline.is_truncated(args.trunc_width) and '%-2l│%-2v' or '󰉸 %-2l│󱥖 %-2v'
            end

            local filetype = section_filetype({ trunc_width = 70 })
            local searchcount = section_searchcount({ trunc_width = 80 })
            local loc = section_location({ trunc_width = 120 })
            local lsp_clients = section_lsp_clients({ trunc_width = 60 })

            return MiniStatusline.combine_groups({
                { hl = mode_hl, strings = { mode:upper() } },
                { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
                '%<',
                { hl = 'MiniStatuslineFilename', strings = { filename } },
                '%=',
                { hl = 'MiniStatuslineDevinfo', strings = { lsp_clients } },
                { hl = mode_hl, strings = { filetype, searchcount, loc } },
            })
        end,

        inactive = function()
            return MiniStatusline.combine_groups({
                { hl = 'MiniStatuslineInactive', strings = { vim.fn.expand('%:t') } },
            })
        end,
    },
})
-- vim.pack.add({
--     'https://github.com/nvim-tree/nvim-web-devicons',
--     'https://github.com/nvim-lualine/lualine.nvim'
-- })
--
-- local function show_macro_recording()
-- 	local recording_register = vim.fn.reg_recording()
-- 	if recording_register == "" then
-- 		return ""
-- 	else
-- 		return "󰑋  " .. recording_register
-- 	end
-- end
--
-- local function getWords()
-- 	if vim.bo.filetype == "md" or vim.bo.filetype == "txt" or vim.bo.filetype == "markdown" then
-- 		if vim.fn.wordcount().visual_words == 1 then
-- 			return tostring(vim.fn.wordcount().visual_words) .. " word"
-- 		elseif not (vim.fn.wordcount().visual_words == nil) then
-- 			return tostring(vim.fn.wordcount().visual_words) .. " words"
-- 		else
-- 			return tostring(vim.fn.wordcount().words) .. " words"
-- 		end
-- 	else
-- 		return ""
-- 	end
-- end
-- local function place()
-- 	local colPre = "C:"
-- 	local col = "%c"
-- 	local linePre = " L:"
-- 	local line = "%l/%L"
-- 	return string.format("%s%s%s%s", colPre, col, linePre, line)
-- end
--
-- require('lualine').setup {
-- 			options = {
-- 				icons_enabled = true,
-- 				-- theme = "ayu_mirage",
-- 				theme = "auto",
-- 				-- section_separators = { left = "", right = "" },
-- 				-- component_separators = { left = "╲", right = "╱" },
-- 				component_separators = { " ", " " },
-- 				section_separators = { " ", " " },
-- 				disabled_filetypes = {
-- 					statusline = {},
-- 					winbar = {},
-- 				},
-- 				ignore_focus = {},
-- 				always_divide_middle = true,
-- 				globalstatus = true,
-- 				refresh = {
-- 					statusline = 1000,
-- 					tabline = 1000,
-- 					winbar = 1000,
-- 				},
-- 			},
-- 			sections = {
-- 				lualine_a = { "mode" },
-- 				lualine_b = { "branch", "man", "searchcount", "diagnostics" },
-- 				lualine_c = {
-- 					function()
-- 						return "%="
-- 					end,
-- 					{
-- 						"filename",
-- 						file_status = true,
-- 						path = 1,
-- 						shorting_target = 40,
-- 						symbols = {
-- 							modified = "󰐖", -- Text to show when the file is modified.
-- 							readonly = "", -- Text to show when the file is non-modifiable or readonly.
-- 							unnamed = "[No Name]", -- Text to show for unnamed buffers.
-- 							newfile = "[New]", -- Text to show for new created file before first writting
-- 						},
-- 					},
-- 					{
-- 						getWords,
-- 						color = { fg = "#333333", bg = "#eeeeee" },
-- 						separator = { left = "", right = "" },
-- 					},
-- 					{
-- 						"searchcount",
-- 					},
-- 					{
-- 						"selectioncount",
-- 					},
-- 					{
-- 						show_macro_recording,
-- 						color = { fg = "#333333", bg = "#ff6666" },
-- 						separator = { left = "", right = "" },
-- 					},
-- 				},
-- 				-- lualine_c = { { "filename", file_status = true, path = 4 } },
-- 				-- lualine_x = { { navic.get_location, cond = navic.is_available } },
-- 				lualine_x = {
-- 					-- {
-- 					-- 	function()
-- 					-- 		return require("nvim-navic").get_location()
-- 					-- 	end,
-- 					-- 	cond = function()
-- 					-- 		return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
-- 					-- 	end,
-- 					-- },
-- 				},
-- 				-- lualine_x = { "encoding", "fileformat", "filetype" },
-- 				lualine_y = { "progress", "filetype" },
-- 				lualine_z = { "location", "place" },
-- 			},
-- 			inactive_sections = {
-- 				lualine_a = {},
-- 				lualine_b = {},
-- 				lualine_c = { "filename" },
-- 				lualine_x = { "location" },
-- 				lualine_y = {},
-- 				lualine_z = {},
-- 			},
-- 			tabline = {},
-- 			winbar = {},
-- 			inactive_winbar = {},
-- 			extensions = { "fzf", "man", "toggleterm" },
--       }
