--which-key
vim.pack.add { 'https://github.com/folke/which-key.nvim' }

-- Documenting with which-key
local wk = require 'which-key'
wk.setup {
  preset = 'modern',
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      windows = false,
      nav = false,
      z = false,
      g = false,
    },
  },
  win = {
    border = 'rounded',
    no_overlap = false,
    padding = { 0, 2 },
    title = false,
    title_pos = 'center',
    zindex = 1000,
  },
  show_help = false,
  show_keys = false,
  disable = {
    buftypes = {},
  },
}

wk.add {
  { '<leader>b', group = 'Buffer' },
  { '<leader>c', group = 'Code' },
  { '<leader>l', group = 'LSP' },
  { '<leader>m', group = 'Markdown' },
  { '<leader>f', group = 'File' },
  { '<leader>g', group = 'Git' },
  { '<leader>p', group = 'Pandoc' },
  { '<leader>o', group = 'Other' },
  -- { "<leader>m", group = "Format or Linting" },
  { '<leader>r', group = 'Rename' },
  { '<leader>s', group = 'Search' },
  { '<leader>t', group = 'Telescope' },
  { '<leader>u', group = 'Buffers' },
  { '<leader>q', group = 'Quit' },
  { '<leader>w', group = 'Wins' },
}
