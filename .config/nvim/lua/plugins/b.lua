vim.pack.add {
  'https://github.com/saghen/blink.lib',
  'https://github.com/saghen/blink.cmp',
}
local cmp = require 'blink.cmp'
cmp.build():pwait()
cmp.setup()

require('blink.cmp').setup {
        keymap = {
                ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
['<C-e>'] = { 'hide', 'fallback' },

['<Tab>'] = {
  function(cmp)
    if cmp.snippet_active() then return cmp.accept()
    else return cmp.select_and_accept() end
  end,
  'snippet_forward',
  'fallback'
},
['<S-Tab>'] = { 'snippet_backward', 'fallback' },

['<Up>'] = { 'select_prev', 'fallback' },
['<Down>'] = { 'select_next', 'fallback' },
['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },
  -- keymap = {
  --   preset = 'enter',
  --   ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
  --   ['<C-e>']     = { 'hide' },
  --   ['<C-k>']     = { 'show_signature', 'hide_signature', 'fallback' },
  -- },
  appearance = {
    nerd_font_variant = 'mono',
  },
  completion = {
    trigger = {
      show_on_insert_on_trigger_character = true,
    },
    list = {
      max_items = 200,
      selection = {
        preselect = true,
        auto_insert = false,
      },
    },
    menu = {
      border = 'single',
      min_width = 20,
      max_height = 20,
      draw = {
        columns = {
          { 'kind_icon', gap = 1 },
          { 'label', 'label_description', gap = 2 },
          { 'kind' },
          { 'source_name' },
        },
        components = {
          kind_icon = {
            ellipsis = false,
            text = function(ctx) return ctx.kind_icon .. ' ' end,
          },
          label = {
            width = { fill = true, max = 40 },
          },
          source_name = {
            text = function(ctx)
              local map = {
                lsp = '[LSP]',
                buffer = '[Buf]',
                snippets = '[Snip]',
                path = '[Path]',
              }
              return map[ctx.source_name] or ('[' .. ctx.source_name .. ']')
            end,
          },
        },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = {
        border = 'single',
        max_width = 60,
        max_height = 20,
      },
    },
    ghost_text = { enabled = true },
  },
  signature = {
    enabled = true,
    window = { border = 'single' },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
}
