-- Prevent loading the plugin multiple times
if vim.g.loaded_nvim_jinja then
  return
end
vim.g.loaded_nvim_jinja = 1

-- Only load if Neovim version is supported
if vim.fn.has("nvim-0.7") == 0 then
  vim.api.nvim_err_writeln("nvim-jinja requires Neovim 0.7+")
  return
end

local nvim_jinja = require("nvim-jinja")

-- Create autocommand group
local augroup = vim.api.nvim_create_augroup("NvimJinja", { clear = true })

-- Setup filetype detection and injection
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "yaml.j2" },
  callback = function()
    nvim_jinja.on_filetype()
  end,
  desc = "Setup jinja injection for yaml.j2 files",
})

-- Create user commands
vim.api.nvim_create_user_command("JinjaEnable", function()
  nvim_jinja.enable()
end, {
  desc = "Enable jinja injection for current buffer",
})

vim.api.nvim_create_user_command("JinjaDisable", function()
  nvim_jinja.disable()
end, {
  desc = "Disable jinja injection for current buffer",
})

vim.api.nvim_create_user_command("JinjaToggle", function()
  nvim_jinja.toggle()
end, {
  desc = "Toggle jinja injection for current buffer",
})

vim.api.nvim_create_user_command("JinjaInfo", function()
  nvim_jinja.info()
end, {
  desc = "Show nvim-jinja plugin information",
})
