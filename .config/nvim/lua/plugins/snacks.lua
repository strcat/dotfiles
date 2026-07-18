vim.pack.add { { src = 'https://github.com/folke/snacks.nvim' } }

require('snacks').setup {
  bigfile = { enabled = false },
  bufdelete = { enabled = false },
  dashboard = { enabled = false },
  debug = { enabled = false },
  dim = { enabled = false },
  input = { enabled = false },
  layout = { enabled = true },
  image = { enabled = true },
  indent = { enabled = false },
  picker = { enabled = true },
  profiler = { enabled = false },
  quickfile = { enabled = false },
  scope = { enabled = false },
  spell = { enabled = true },
  statuscolumn = { enabled = false },
  words = { enabled = false },
  explorer = {
    enabled = true,
    trash = true,
  },
  notifier = {
    enabled = true,
    timeout = 3000,
    style = 'fancy',
  },
  terminal = {
    enabled = true,
    win = {
      style = 'terminal',
      border = vim.g.border_style,
      position = 'float',
      height = 0.5,
      width = 0.6,
    },
  },
  styles = {
    notification = {
      border = vim.g.border_style,
      wo = { wrap = true }, -- Wrap notifications
      history = {
        border = vim.g.border_style,
      },
    },
    scratch = {
      border = vim.g.border_style,
    },
  },
}

-- -- stylua: ignore start
vim.keymap.set('n', '<leader>n', function() Snacks.notifier.show_history() end, { desc = 'Notification History' })
vim.keymap.set('n', '<leader>un', function() Snacks.notifier.hide() end, { desc = 'Dismiss All Notifications' })
vim.keymap.set('n', '<leader>Lg', function() Snacks.lazygit() end, { desc = 'Lazygit' })
vim.keymap.set({ 'n', 't' }, '<leader>ot', function() Snacks.terminal.toggle() end, { desc = 'Toggle Terminal' })
vim.keymap.set({ 'n', 't' }, '<leader>e', function() Snacks.explorer { auto_close = true, follow_file = false } end, { desc = 'File Explorer' })
-- -- stylua: ignore end
