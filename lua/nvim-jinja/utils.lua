local M = {}

function M.get_ft()
	local filename = vim.api.nvim_buf_get_name(0)
	local _, _, ft = string.find(filename, "%.(%w+)%.j2$")

	return ft
end

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

--- @param msg string
function M.debug(msg)
	local config = require("nvim-jinja.config")
	if config.options.debug then
		vim.notify("[nvim-jinja] " .. msg, vim.log.levels.DEBUG)
	end
end

--- @param msg string
function M.info(msg)
	vim.notify("[nvim-jinja] " .. msg, vim.log.levels.INFO)
end

--- @param msg string
function M.warn(msg)
	vim.notify("[nvim-jinja] " .. msg, vim.log.levels.WARN)
end

--- @param msg string
function M.error(msg)
	vim.notify("[nvim-jinja] " .. msg, vim.log.levels.ERROR)
end

--- @return string
function M.get_file_path()
	return vim.api.nvim_buf_get_name(0)
end

return M
