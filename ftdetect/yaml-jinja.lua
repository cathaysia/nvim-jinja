-- File type detection for yaml.j2 files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.yaml.j2",
  callback = function()
    vim.bo.filetype = "yaml.j2"
  end,
})
