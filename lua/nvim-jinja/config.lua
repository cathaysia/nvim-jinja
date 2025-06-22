local M = {}

-- Default configuration
M.defaults = {
    enabled = true,
    debug = false,
    filetypes = {
        "yaml.j2",
        ["html.j2"] = "html",
        ["xml.j2"] = "xml",
        ["json.j2"] = "json",
        ["css.j2"] = "css",
        ["js.j2"] = "javascript",
        ["ts.j2"] = "typescript",
    },
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
return M.get_inject_language(ft) ~=nil
end

-- Get inject language for filetype
function M.get_inject_language(ft)
    -- Check if it's a key-value pair
    if M.options.filetypes[ft] then
        return M.options.filetypes[ft]
    end

    -- Check if it's a string in the array part
    for i, config in ipairs(M.options.filetypes) do
        if type(config) == "string" and config == ft then
            return ft
        end
    end

    return nil

end

-- Initialize with defaults
M.setup()

return M
