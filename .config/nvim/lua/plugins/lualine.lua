local function show_macro_recording()
	local recording_register = vim.fn.reg_recording()
	if recording_register == "" then
		return ""
	else
		return "󰑋  " .. recording_register
	end
end

local function getWords()
	if vim.bo.filetype == "md" or vim.bo.filetype == "txt" or vim.bo.filetype == "markdown" then
		if vim.fn.wordcount().visual_words == 1 then
			return tostring(vim.fn.wordcount().visual_words) .. " word"
		elseif not (vim.fn.wordcount().visual_words == nil) then
			return tostring(vim.fn.wordcount().visual_words) .. " words"
		else
			return tostring(vim.fn.wordcount().words) .. " words"
		end
	else
		return ""
	end
end
local function place()
	local colPre = "C:"
	local col = "%c"
	local linePre = " L:"
	local line = "%l/%L"
	return string.format("%s%s%s%s", colPre, col, linePre, line)
end

return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = function()
		return {
			--[[add your custom lualine config here]]
			options = {
				icons_enabled = true,
				-- theme = "ayu_mirage",
				theme = "auto",
				-- section_separators = { left = "", right = "" },
				-- component_separators = { left = "╲", right = "╱" },
				component_separators = { " ", " " },
				section_separators = { " ", " " },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "man", "searchcount", "diagnostics" },
				lualine_c = {
					function()
						return "%="
					end,
					{
						"filename",
						file_status = true,
						path = 1,
						shorting_target = 40,
						symbols = {
							modified = "󰐖", -- Text to show when the file is modified.
							readonly = "", -- Text to show when the file is non-modifiable or readonly.
							unnamed = "[No Name]", -- Text to show for unnamed buffers.
							newfile = "[New]", -- Text to show for new created file before first writting
						},
					},
					{
						getWords,
						color = { fg = "#333333", bg = "#eeeeee" },
						separator = { left = "", right = "" },
					},
					{
						"searchcount",
					},
					{
						"selectioncount",
					},
					{
						show_macro_recording,
						color = { fg = "#333333", bg = "#ff6666" },
						separator = { left = "", right = "" },
					},
				},
				-- lualine_c = { { "filename", file_status = true, path = 4 } },
				-- lualine_x = { { navic.get_location, cond = navic.is_available } },
				lualine_x = {
					-- {
					-- 	function()
					-- 		return require("nvim-navic").get_location()
					-- 	end,
					-- 	cond = function()
					-- 		return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
					-- 	end,
					-- },
				},
				-- lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress", "filetype" },
				lualine_z = { "location", "place" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = { "fzf", "man", "toggleterm" },
		}
	end,
}
