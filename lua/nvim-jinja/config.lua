local M = {}

-- Default configuration
M.defaults = {
  enabled = true,
  debug = false,
  filetypes = { "yaml.j2" },
  inject_language = "yaml",
  auto_install_parsers = false,
}

-- Current configuration
M.options = {}

-- Setup configuration
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

-- Get configuration option
function M.get(key)
  return M.options[key]
end

-- Check if plugin is enabled
function M.is_enabled()
  return M.options.enabled
end

-- Check if filetype is supported
function M.is_supported_filetype(ft)
  return vim.tbl_contains(M.options.filetypes, ft)
end

-- Initialize with defaults
M.setup()

return M
