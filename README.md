# nvim-jinja

A Neovim plugin that provides treesitter injection for Jinja templates in YAML files (`.yaml.j2`).

## Features

- Automatic detection of `.yaml.j2` files
- Treesitter injection of YAML syntax into Jinja content nodes
- Seamless syntax highlighting for mixed Jinja/YAML content
- User commands for manual control
- Debug mode for troubleshooting

## Requirements

- Neovim 0.7+
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- tree-sitter-jinja parser
- tree-sitter-yaml parser

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
  filetypes = { "yaml.j2" },         -- Supported file types
  inject_language = "yaml",          -- Language to inject
  auto_install_parsers = false,      -- Auto install missing parsers
})
```

## Usage

The plugin automatically activates when you open a `.yaml.j2` file. No manual configuration is required.

### Commands

- `:JinjaEnable` - Enable jinja injection for current buffer
- `:JinjaDisable` - Disable jinja injection for current buffer
- `:JinjaToggle` - Toggle jinja injection for current buffer
- `:JinjaInfo` - Show plugin status and information

### API

```lua
local nvim_jinja = require("nvim-jinja")

-- Enable injection for current buffer
nvim_jinja.enable()

-- Disable injection for current buffer
nvim_jinja.disable()

-- Toggle injection for current buffer
nvim_jinja.toggle()

-- Get plugin status
local status = nvim_jinja.status()

-- Print plugin information
nvim_jinja.info()
```

## Installing Required Parsers

Make sure you have the required treesitter parsers installed:

```vim
:TSInstall jinja yaml
```

Or add them to your treesitter configuration:

```lua
require("nvim-treesitter.configs").setup({
  ensure_installed = { "jinja", "yaml", ... },
})
```

## How It Works

1. The plugin detects `.yaml.j2` files and sets the filetype to `yaml.j2`
2. When the filetype is detected, it configures treesitter to use the jinja parser
3. The injection rules in `queries/jinja/injections.scm` tell treesitter to inject YAML syntax into Jinja content nodes
4. This provides proper syntax highlighting for both Jinja template syntax and YAML content

## Troubleshooting

### Check Plugin Status

Use `:JinjaInfo` to see the current status of the plugin and check if all dependencies are available.

### Enable Debug Mode

```lua
require("nvim-jinja").setup({
  debug = true,
})
```

### Common Issues

1. **No syntax highlighting**: Make sure both `jinja` and `yaml` parsers are installed
2. **Plugin not loading**: Check that you have Neovim 0.7+ and nvim-treesitter installed
3. **Injection not working**: Verify that the file has the `.yaml.j2` extension

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

## License

MIT License
