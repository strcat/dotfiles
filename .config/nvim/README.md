# Neovim 0.12 configuration

> [!NOTE]
> This configuration requires Neovim 0.12 or newer and is still under
> development!

## The file structure looks as follows:
```bash
.
├── snippets
│   ├── zsh.json
│   ├── package.json
│   ├── markdown.json
│   ├── lua.json
│   ├── html.json
│   ├── cpp.json
│   └── adoc.json
├── nvim-pack-lock.json
├── lua
│   ├── plugins
│   │   ├── which-key.lua
│   │   ├── tmux-navi.lua
│   │   ├── statusline.lua
│   │   ├── snacks.lua
│   │   ├── misc.lua
│   │   ├── mini.lua
│   │   ├── mdplus.lua
│   │   ├── mason.lua
│   │   ├── markdown.lua
│   │   ├── gitsigns.lua
│   │   ├── fzflua.lua
│   │   ├── fff.lua
│   │   ├── conform.lua
│   │   ├── colorscheme.lua
│   │   ├── blink.lua
│   │   └── b.lua
│   └── config
│       ├── options.lua
│       ├── keymaps.lua
│       └── autocmds.lua
└── init.lua
```
## Some - more or less - useful informations
The plugins and keybindings are not loaded from a central file but are called
within the configuration file. So, *mason.lua* not only contains `vim.pack.add`,
but also the keybindings for mason.

> [!CAUTION]
> As I said, this configuration is still under development; that means "it works
> for me," but it doesn't mean it will work for others.

