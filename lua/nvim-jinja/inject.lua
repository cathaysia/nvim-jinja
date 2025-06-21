local utils = require("nvim-jinja.utils")
local config = require("nvim-jinja.config")

local M = {}

-- Setup injection rules for the current buffer
function M.setup_injection(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  if not config.is_enabled() then
    utils.debug("Plugin is disabled")
    return false
  end

  -- Check if treesitter is available
  if not utils.has_treesitter() then
    utils.warn("nvim-treesitter is not available")
    return false
  end

  -- Check if required parsers are installed
  if not utils.has_jinja_parser() then
    utils.error("jinja parser is not installed. Please install tree-sitter-jinja")
    return false
  end

  if not utils.has_yaml_parser() then
    utils.error("yaml parser is not installed. Please install tree-sitter-yaml")
    return false
  end

  utils.debug("Setting up injection for buffer " .. bufnr)

  -- Set the buffer's parser to jinja
  local ok, ts_parsers = pcall(require, "nvim-treesitter.parsers")
  if not ok then
    utils.error("Failed to load nvim-treesitter.parsers")
    return false
  end

  -- Configure the buffer to use jinja parser
  vim.api.nvim_buf_set_option(bufnr, "syntax", "")

  -- Set treesitter parser for this buffer
  local parser_config = ts_parsers.get_parser_configs()
  if parser_config.jinja then
    utils.debug("Jinja parser configuration found")

    -- Force treesitter to use jinja parser for this buffer
    vim.treesitter.start(bufnr, "jinja")

    utils.info("Successfully configured jinja treesitter with yaml injection")
    return true
  else
    utils.error("Jinja parser configuration not found")
    return false
  end
end

-- Remove injection rules for the current buffer
function M.remove_injection(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  utils.debug("Removing injection for buffer " .. bufnr)

  -- Stop treesitter for this buffer
  vim.treesitter.stop(bufnr)

  -- Reset syntax
  vim.api.nvim_buf_set_option(bufnr, "syntax", "yaml")
end

-- Check if injection is active for buffer
function M.is_injection_active(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  local parser = vim.treesitter.get_parser(bufnr)
  if not parser then
    return false
  end

  return parser:lang() == "jinja"
end

return M
