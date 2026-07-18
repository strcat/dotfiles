vim.pack.add { 'https://github.com/ibhagwan/fzf-lua', 'https://github.com/elanmed/fzf-lua-frecency.nvim' }

require('fzf-lua-frecency').setup()
require('fzf-lua').setup {
  defaults = {
    git_icons = false,
    file_icons = false,
    color_icons = false,
  },
  fzf_opts = {
    ['--info'] = 'default',
    ['--layout'] = 'reverse-list',
    ['--header-first'] = false,
    ['--color'] = 'bg+:-1,fg+:blue,pointer:magenta,marker:magenta,prompt:gray,header:gray',
  },
  winopts = {
    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    preview = {
      title = true,
      layout = 'horizontal',
      width = 0.95,
      vertical = 'up:75%',
    },
  },
  files = {
    formatter = 'path.filename_first',
    git_icons = true,
    file_icons = true,
    prompt = 'Files> ',
    no_header = true,
    cwd_header = true,
    cwd_prompt = true,
  },
  grep = {
    prompt = 'Rg❯ ',
    input_prompt = 'Grep For❯ ',
    git_icons = true,
    no_header = true,
    no_header_i = true,
    cwd_header = false,
    cwd_prompt = false,
  },
  git = {
    status = {
      prompt = 'Git Status> ',
      formatter = 'path.filename_first',
      git_icons = true,
      no_header = true,
      cwd_header = false,
      cwd_prompt = false,
    },
  },
  diagnostics = {
    formatter = 'path.filename_first',
    git_icons = true,
    prompt = 'Diagnostics> ',
    no_header = true,
    cwd_header = false,
    cwd_prompt = false,
  },
}

-- FzfLua
local set = vim.keymap.set
set('n', '<leader>,', ':FzfLua buffers<CR>', { desc = 'FzfLua Buffer' })
set('n', '<leader>tg', ':FzfLua live_grep_native<CR>', { desc = 'FzfLua livegrep' })
set('n', '<leader>tm', ':FzfLua marks<CR>', { desc = 'FzfLua marks' })
set('n', '<leader>ff', ':FzfLua files<CR>', { desc = 'FzfLua Files' })
set('n', '<leader>tr', ':FzfLua resume<CR>', { desc = 'FzfLua resume' })
set('n', '<leader>tF', function() require('fzf-lua').files { cwd = '~' } end, { desc = 'Files in $HOME' })
set('n', '=z', ':FzfLua spell_suggest<CR>', { desc = 'Spelling Suggestion (FZF)' })
set('n', '<leader><leader>', ':FzfLua frecency<CR>', { desc = 'FzfLua frecency' })
set('n', '<leader>tk', ':FzfLua keymaps<CR>', { desc = 'FzfLua Keymaps' })
set('n', '<leader>ts', ':FzfLua spell_suggest<CR>', { desc = 'FzfLua spellsuggest' })
set('n', '<leader>U', ':FzfLua undotree<CR>', { desc = 'FzfLua Undotree' })
