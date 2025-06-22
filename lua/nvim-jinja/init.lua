local config = require("nvim-jinja.config")
local inject = require("nvim-jinja.inject")
local utils = require("nvim-jinja.utils")

local M = {}

-- Setup the plugin
function M.setup(opts)
	config.setup(opts)

	M.on_filetype()
end

-- Get plugin status
function M.status()
	local status = {
		enabled = config.is_enabled(),
		supported_filetype = config.is_supported_filetype(),
		has_treesitter = utils.has_treesitter(),
		has_jinja_parser = utils.has_jinja_parser(),
		has_yaml_parser = utils.has_yaml_parser(),
	}

	return status
end

-- Print plugin status
function M.info()
	local status = M.status()

	print("nvim-jinja status:")
	print("  Enabled: " .. tostring(status.enabled))
	print("  Supported filetype: " .. tostring(status.supported_filetype))
	print("  Has treesitter: " .. tostring(status.has_treesitter))
	print("  Has jinja parser: " .. tostring(status.has_jinja_parser))
	print("  Has yaml parser: " .. tostring(status.has_yaml_parser))
	print("  Injection active: " .. tostring(status.injection_active))
	print("  Config", vim.inspect(config.options))
end

-- Handle filetype event
function M.on_filetype()
	local ft = config.get_inject_language()
	if ft == nil then
		return
	end

	utils.debug("FileType event triggered: " .. ft)

	if config.is_supported_filetype() then
		utils.debug("Supported filetype detected, setting up injection")
		inject.setup_injection(ft)
		vim.bo.filetype = "jinja"
	end
end

return M
