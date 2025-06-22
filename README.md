# nvim-jinja(WIP)

A Neovim plugin that provides treesitter injection for Jinja templates in YAML files (`.ft.j2`).

## Features

- Automatic detection of `.ft.j2` files
- Treesitter injection of filetype syntax into Jinja content nodes
- Seamless syntax highlighting for mixed Jinja/filetype content
- User commands for manual control
- Debug mode for troubleshooting

## Requirements

- Neovim 0.7+
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- tree-sitter-jinja parser
- tree-sitter-x parser

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "your-username/nvim-jinja",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("nvim-jinja").setup()
  end,
}
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "your-username/nvim-jinja",
  requires = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("nvim-jinja").setup()
  end,
}
```

## Setup

```lua
require("nvim-jinja").setup({
  enabled = true,                    -- Enable the plugin
  debug = false,                     -- Enable debug messages
  filetypes = {
    extensions = {
      ["html"] = "html",
      ["yaml.j2"] = "yaml",
      ["html.j2"] = "html",
      ["xml.j2"] = "xml",
      ["json.j2"] = "json",
      ["css.j2"] = "css",
      ["js.j2"] = "javascript",
      ["ts.j2"] = "typescript",
    },
    complex = {
      [".*git/config.j2"] = "gitconfig",
      [".*layouts/.*.html"] = "html",
    },
  },
  auto_install_parsers = false,      -- Auto install missing parsers
})
```
