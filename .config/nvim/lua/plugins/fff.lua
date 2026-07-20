vim.pack.add { 'https://github.com/dmtrKovalenko/fff.nvim' }

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'fff.nvim' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then vim.cmd.packadd 'fff.nvim' end
      require('fff.download').download_or_build_binary()
    end
  end,
})

require('fff').setup {
  prompt = ' ',
  lazy_sync = true,
  layout = {
    height = 0.8,
    width = 0.8,
    prompt_position = 'bottom', -- or 'top'
    preview_position = 'right', -- or 'left', 'right', 'top', 'bottom'
    preview_size = 0.5,
    flex = { -- set to false to disable flex layout
      size = 130, -- column threshold: if screen width >= size, use preview_position; otherwise use wrap
      wrap = 'top', -- position to use when screen is narrower than size
    },
    show_scrollbar = true, -- Show scrollbar for pagination
    -- How to shorten long directory paths in the file list:
    -- 'middle_number' (default): uses dots for 1-3 hidden (a/./b, a/../b, a/.../b)
    --                            and numbers for 4+ (a/.4./b, a/.5./b)
    -- 'middle': always uses dots (a/./b, a/../b, a/.../b)
    -- 'end': truncates from the end (home/user/projects)
    path_shorten_strategy = 'middle_number',
    anchor = 'center', -- picker placement: 'center', 'top_left', 'top', 'top_right', 'left', 'right', 'bottom_left', 'bottom', 'bottom_right'
  },
  frecency = {
    enabled = true,
    db_path = vim.fn.stdpath 'cache' .. '/fff_nvim',
  },
  -- Store successfully opened queries with respective matches
  history = {
    enabled = true,
    db_path = vim.fn.stdpath 'data' .. '/fff_queries',
    min_combo_count = 3, -- Minimum selections before combo boost applies (3 = boost starts on 3rd selection)
    combo_boost_score_multiplier = 100, -- Score multiplier for combo matches (files repeatedly opened with same query)
  },
  -- Git integration
  git = {
    status_text_color = false, -- Apply git status colors to filename text (default: false, only sign column)
  },
  preview = {
    enabled = true,
    max_size = 10 * 1024 * 1024, -- Do not try to read files larger than 10MB
    chunk_size = 8192, -- Bytes per chunk for dynamic loading (8kb - fits ~100-200 lines)
    binary_file_threshold = 1024, -- amount of bytes to scan for binary content (set 0 to disable)
    imagemagick_info_format_str = '%m: %wx%h, %[colorspace], %q-bit',
    line_numbers = false,
    cursorlineopt = 'both', -- the cursorlineopt used for lines in grep file previews, see :h cursorlineopt
    wrap_lines = false,
    filetypes = {
      svg = { wrap_lines = true },
      markdown = { wrap_lines = true },
      text = { wrap_lines = true },
    },
  },
}
vim.keymap.set('n', '<leader>fcw', function() require('fff').live_grep_under_cursor() end, { desc = 'FFFind current word / selection' })
vim.keymap.set('n', '<leader>ff', function() require('fff').find_files() end, { desc = 'FFFind files' })
vim.keymap.set('n', '<leader>fg', function() require('fff').live_grep() end, { desc = 'LiFFFe grep' })
vim.keymap.set(
  'n',
  'Fz',
  function()
    require('fff').live_grep {
      grep = {
        modes = { 'fuzzy', 'plain' },
      },
    }
  end,
  { desc = 'Live fffuzy grep' }
)
