vim.pack.add {
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
}
require('mason').setup {}
require('mason-lspconfig').setup {
  ensure_installed = {
    'cssls',
    'cssmodules_ls',
    'html',
    'lua_ls',
    'superhtml',
    'tailwindcss',
    'vimls',
    'yamlls'
  },
}
