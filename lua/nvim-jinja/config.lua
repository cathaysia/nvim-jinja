local M = {}

-- Default configuration
M.defaults = {
	enabled = true,
	debug = false,
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
}

-- Current configuration
M.options = {}

function M.get_inject_language()
	local filepath = vim.api.nvim_buf_get_name(0)
	local filename = vim.fn.fnamemodify(filepath, ":t")

	-- Get filetypes configuration
	local filetypes = M.options.filetypes
	if not filetypes then
		return nil
	end

	-- Check extensions first
	if filetypes.extensions then
		for ext, ft in pairs(filetypes.extensions) do
			if vim.endswith(filename, ext) then
				return ft
			end
		end
	end

	-- Check complex patterns
	if filetypes.complex then
		for pattern, ft in pairs(filetypes.complex) do
			if string.match(filepath, pattern) then
				return ft
			end
		end
	end

	return nil
end

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
function M.is_supported_filetype()
	return M.get_inject_language() ~= nil
end

-- Initialize with defaults
M.setup()

return M
