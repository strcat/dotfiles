return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        {
            'b0o/nvim-tree-preview.lua',
            dependencies = { 'nvim-lua/plenary.nvim' },
        },
    },
    config = function()
        local preview = require 'nvim-tree-preview'
        local function my_on_attach(bufnr)
            local api = require "nvim-tree.api"

            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- default mappings
            api.config.mappings.default_on_attach(bufnr)

            -- custom mappings
            vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
            vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
            vim.keymap.set('n', 'P', preview.watch, opts 'Preview (Watch)')
            vim.keymap.set('n', '<Esc>', preview.unwatch, opts 'Close Preview/Unwatch')
            vim.keymap.set('n', '<Tab>', function()
                local ok, node = pcall(api.tree.get_node_under_cursor)
                if ok and node then
                    if node.type == 'directory' then
                        api.node.open.edit()
                    else
                        preview.node(node, { toggle_focus = true })
                    end
                end
            end, opts 'Preview')
        end

        require("nvim-tree").setup({
            on_attach = my_on_attach,
            diagnostics = {
                enable = true,
            },
            update_focused_file = {
                enable = true,
            },
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = 24,
                side = 'left',
            },
            filters = {
                dotfiles = true,
            },
            git = {
                ignore = false,
            },
            actions = {
                open_file = {
                    window_picker = {
                        enable = false,
                    },
                },
            },
            renderer = {
                icons = {
                    show = {
                        git = true,
                        folder = true,
                        file = true,
                        folder_arrow = false,
                    },
                    glyphs = {
                        default = '',
                        git = {
                            unstaged = '✗',
                            staged = '✓',
                            unmerged = '',
                            renamed = '➜',
                            untracked = '?',
                            deleted = '',
                            ignored = '◌',
                        },
                    },
                },
                indent_markers = {
                    enable = true,
                },
            },
        })


        -- Default config:
        preview.setup({
            -- Keymaps for the preview window (does not apply to the tree window).
            -- Keymaps can be a string (vimscript command), a function, or a table.
            --
            -- If a table, it must contain either an 'action' or 'open' key:
            --
            -- Actions:
            --   { action = 'close', unwatch? = false, focus_tree? = true }
            --   { action = 'toggle_focus' }
            --
            -- Open modes:
            --   { open = 'edit' }
            --   { open = 'tab' }
            --   { open = 'vertical' }
            --   { open = 'horizontal' }
            --
            -- To disable a default keymap, set it to false.
            -- All keymaps are set in normal mode. Other modes are not currently supported.
            keymaps = {
                ['<Esc>'] = { action = 'close', unwatch = true },
                ['<Tab>'] = { action = 'toggle_focus' },
                ['<CR>'] = { open = 'edit' },
                ['<C-t>'] = { open = 'tab' },
                ['<C-v>'] = { open = 'vertical' },
                ['<C-x>'] = { open = 'horizontal' },
            },
            min_width = 10,
            min_height = 5,
            max_width = 85,
            max_height = 25,
            wrap = false,       -- Whether to wrap lines in the preview window
            border = 'rounded', -- Border style for the preview window
        })
	    -- vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Filemanager" })
    end,
}

