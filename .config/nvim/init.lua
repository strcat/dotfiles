-- Some stuff is shameless stolen https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
--
-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

-- removes "Press Enter" interruptions, and it highlights the command line as you type
require('vim._core.ui2').enable {
  enable = true,
  msg = {
    target = 'msg',
    pager = { height = 0.5 },
    dialog = { height = 0.5 },
    cmd = { height = 0.5 },
    msg = { height = 0.5, timeout = 4500 },
  },
}

local function run_build(name, cmd, cwd)
  local result = vim.system(cmd, { cwd = cwd }):wait()
  if result.code ~= 0 then
    local stderr = result.stderr or ''
    local stdout = result.stdout or ''
    local output = stderr ~= '' and stderr or stdout
    if output == '' then output = 'No output from build command.' end
    vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
  end
end

-- This autocommand runs after a plugin is installed or updated and
--  runs the appropriate build command for that plugin if necessary.
-- See `:help vim.pack-events`
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end
    if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
      run_build(name, { 'make' }, ev.data.path)
      return
    end
    if name == 'LuaSnip' then
      if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then run_build(name, { 'make', 'install_jsregexp' }, ev.data.path) end
      return
    end
    if name == 'nvim-treesitter' then
      if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
      vim.cmd 'TSUpdate'
      return
    end
  end,
})

-- Automatically execute |:nohlsearch| after 'updatetime' or getting into |Insert| mode.
vim.cmd.packadd 'nohlsearch'

-- Options, autocmds,
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'plugins.blink'
require 'plugins.fff'
require 'plugins.mini'
require 'plugins.colorscheme'
require 'plugins.conform'
require 'plugins.fzflua'
require 'plugins.mason'
require 'plugins.gitsigns'
require 'plugins.snacks'
require 'plugins.statusline'
require 'plugins.tmux-navi'
require 'plugins.misc'
require 'plugins.markdown'
require 'plugins.which-key'
