local config = require("nvim-jinja.config")
local inject = require("nvim-jinja.inject")
local utils = require("nvim-jinja.utils")

local M = {}

-- Setup the plugin
function M.setup(opts)
  config.setup(opts)

  utils.debug("nvim-jinja plugin initialized")

  if not config.is_enabled() then
    utils.debug("Plugin is disabled")
    return
  end

  -- Check dependencies
  if not utils.has_treesitter() then
    utils.warn("nvim-treesitter is required for nvim-jinja to work")
    return
  end
end

-- Enable injection for current buffer
function M.enable()
  local bufnr = vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")

  if not config.is_supported_filetype(ft) then
    utils.warn("Filetype '" .. ft .. "' is not supported")
    return false
  end

  return inject.setup_injection(bufnr)
end

-- Disable injection for current buffer
function M.disable()
  local bufnr = vim.api.nvim_get_current_buf()
  inject.remove_injection(bufnr)
  utils.info("Disabled jinja injection for current buffer")
end

-- Toggle injection for current buffer
function M.toggle()
  local bufnr = vim.api.nvim_get_current_buf()

  if inject.is_injection_active(bufnr) then
    M.disable()
  else
    M.enable()
  end
end

-- Get plugin status
function M.status()
  local bufnr = vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")

  local status = {
    enabled = config.is_enabled(),
    supported_filetype = config.is_supported_filetype(ft),
    has_treesitter = utils.has_treesitter(),
    has_jinja_parser = utils.has_jinja_parser(),
    has_yaml_parser = utils.has_yaml_parser(),
    injection_active = inject.is_injection_active(bufnr),
    current_filetype = ft,
  }

  return status
end

-- Print plugin status
function M.info()
  local status = M.status()

  print("nvim-jinja status:")
  print("  Enabled: " .. tostring(status.enabled))
  print("  Current filetype: " .. status.current_filetype)
  print("  Supported filetype: " .. tostring(status.supported_filetype))
  print("  Has treesitter: " .. tostring(status.has_treesitter))
  print("  Has jinja parser: " .. tostring(status.has_jinja_parser))
  print("  Has yaml parser: " .. tostring(status.has_yaml_parser))
  print("  Injection active: " .. tostring(status.injection_active))
end

-- Handle filetype event
function M.on_filetype()
  local bufnr = vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")

  utils.debug("FileType event triggered: " .. ft)

  if config.is_supported_filetype(ft) then
    utils.debug("Supported filetype detected, setting up injection")
    inject.setup_injection(bufnr)
  end
end

return M
