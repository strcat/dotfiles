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
  picker = {
    sources = {
      snippets = {
        supports_live = false,
        preview = 'preview',
        format = function(item, picker)
          local name = Snacks.picker.util.align(item.name, picker.align_1 + 5)
          return {
            { name, item.ft == '' and 'Conceal' or 'DiagnosticWarn' },
            { item.description },
          }
        end,
        finder = function(_, ctx)
          local snippets = {}
          for _, snip in ipairs(require('luasnip').get_snippets().all) do
            snip.ft = ''
            table.insert(snippets, snip)
          end
          for _, snip in ipairs(require('luasnip').get_snippets(vim.bo.ft)) do
            snip.ft = vim.bo.ft
            table.insert(snippets, snip)
          end
          local align_1 = 0
          for _, snip in pairs(snippets) do
            align_1 = math.max(align_1, #snip.name)
          end
          ctx.picker.align_1 = align_1
          local items = {}
          for _, snip in pairs(snippets) do
            local docstring = snip:get_docstring()
            if type(docstring) == 'table' then docstring = table.concat(docstring) end
            local name = snip.name
            local description = table.concat(snip.description)
            description = name == description and '' or description
            table.insert(items, {
              text = name .. ' ' .. description, -- search string
              name = name,
              description = description,
              trigger = snip.trigger,
              ft = snip.ft,
              preview = {
                ft = snip.ft,
                text = docstring,
              },
            })
          end
          return items
        end,
        confirm = function(picker, item)
          picker:close()
          --
          local expand = {}
          require('luasnip').available(function(snippet)
            if snippet.trigger == item.trigger then table.insert(expand, snippet) end
            return snippet
          end)
          if #expand > 0 then
            vim.cmd ':startinsert!'
            vim.defer_fn(function() require('luasnip').snip_expand(expand[1]) end, 50)
          else
            Snacks.notify.warn 'No snippet to expand'
          end
        end,
      },
    },
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
vim.keymap.set('n', '<leader>tl', function() Snacks.picker.snippets() end, { desc = 'LuaSnip Snippets' })
vim.keymap.set({ 'n', 't' }, '<leader>ot', function() Snacks.terminal.toggle() end, { desc = 'Toggle Terminal' })
vim.keymap.set({ 'n', 't' }, '<leader>e', function() Snacks.explorer { auto_close = true, follow_file = false } end, { desc = 'File Explorer' })
-- -- stylua: ignore end
