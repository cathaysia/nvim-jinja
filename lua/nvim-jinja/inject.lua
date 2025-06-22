local config = require("nvim-jinja.config")

local M = {}

-- Setup injection rules for the current buffer
function M.setup_injection(ft)
	local inject = string.format(
		[[
((inline) @injection.content
  (#set! injection.language "jinja_inline"))

((comment) @injection.content
  (#set! injection.language "comment"))

((words) @injection.content
  (#set! injection.language "%s"))
]],
		ft
	)
	vim.treesitter.query.set("jinja", "injections", inject)
end

return M
