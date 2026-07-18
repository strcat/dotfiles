vim.pack.add {
  'https://github.com/saghen/blink.lib',
  'https://github.com/saghen/blink.cmp',
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/rafamadriz/friendly-snippets',
}

local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').load { paths = { './snippets' } }
require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_snipmate').lazy_load()
local cmp = require 'blink.cmp'
cmp.build():pwait()

cmp.setup {
  keymap = {
    preset = 'super-tab',
    ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },
  },
  appearance = { nerd_font_variant = 'mono' },
  completion = {
    documentation = { auto_show = false },
    list = {
      selection = {
        preselect = true,
        auto_insert = true,
      },
    },
  },
  cmdline = { enabled = true },
  snippets = { preset = 'luasnip' },
  sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
}
vim.lsp.config['*'] = {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
}
