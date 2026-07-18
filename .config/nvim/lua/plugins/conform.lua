vim.pack.add {
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/mfussenegger/nvim-lint',
}

require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    c = { 'clang-format' },
    go = { 'goimports', 'gofumpt', stop_after_first = true },
    cs = { 'csharpier' },
    css = { 'prettierd', 'prettier', stop_after_first = true },
    html = { 'prettierd', 'prettier', stop_after_first = true },
    vue = { 'prettierd', 'prettier', stop_after_first = true },
    svelte = { 'prettierd', 'prettier', stop_after_first = true },
    typescript = { 'prettierd', 'prettier', stop_after_first = true },
    typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    json = { 'jq' },
    yaml = { 'yamlfmt' },
    xml = { 'xmlformat' },
    sql = { 'sleek', 'sql-formatter', stop_after_first = true },
    zig = { 'zigfmt' },
  },
}

local lint = require 'lint'
lint.linters_by_ft = {
  javascript = { 'eslint_d' },
  typescript = { 'eslint_d' },
  typescriptreact = { 'eslint_d' },
  javascriptreact = { 'eslint_d' },
  svelte = { 'eslint_d' },
  vue = { 'eslint_d' },
  c = { 'cpplint' },
  go = { 'golangcilint' },
}

lint.linters.cpplint.args = {
  '--filter',
  '-whitespace',
  '-legal/copyright',
}
vim.keymap.set({ 'n', 'v' }, '<Space>cf', function() require('conform').format { async = true, lsp_format = 'fallback' } end, { desc = '[c]ode [f]ormat' })
