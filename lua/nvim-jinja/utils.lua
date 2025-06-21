local M = {}

-- Check if nvim-treesitter is available
function M.has_treesitter()
  local ok, _ = pcall(require, "nvim-treesitter")
  return ok
end

-- Check if jinja parser is installed
function M.has_jinja_parser()
  if not M.has_treesitter() then
    return false
  end

  local parsers = require("nvim-treesitter.parsers")
  return parsers.has_parser("jinja")
end

-- Check if yaml parser is installed
function M.has_yaml_parser()
  if not M.has_treesitter() then
    return false
  end

  local parsers = require("nvim-treesitter.parsers")
  return parsers.has_parser("yaml")
end

-- Log debug message
function M.debug(msg)
  local config = require("nvim-jinja.config")
  if config.options.debug then
    vim.notify("[nvim-jinja] " .. msg, vim.log.levels.DEBUG)
  end
end

-- Log info message
function M.info(msg)
  vim.notify("[nvim-jinja] " .. msg, vim.log.levels.INFO)
end

-- Log warning message
function M.warn(msg)
  vim.notify("[nvim-jinja] " .. msg, vim.log.levels.WARN)
end

-- Log error message
function M.error(msg)
  vim.notify("[nvim-jinja] " .. msg, vim.log.levels.ERROR)
end

return M
