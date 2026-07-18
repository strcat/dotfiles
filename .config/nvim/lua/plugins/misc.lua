vim.pack.add({ 
        { src = "https://github.com/sontungexpt/url-open" },
        { src = "https://github.com/windwp/nvim-ts-autotag" }
})

-- Open URLs 
require("url-open").setup({})
vim.keymap.set("n", "gx", "<cmd>URLOpenUnderCursor<cr>", { desc = "Open URL" })

-- autotag
require("nvim-ts-autotag").setup({})
