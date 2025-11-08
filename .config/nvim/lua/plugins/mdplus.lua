return
{
  "yousefhadder/markdown-plus.nvim",
  ft = { "markdown", "text", "txt" },  -- Match your filetypes config
  config = function()
	require("markdown-plus").setup({
		filetypes = { "markdown", "text", "txt" },
	})
  end,
}
