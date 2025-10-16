-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Enable/disable swap files
vim.opt.swapfile = true

-- Do not show tabline at the top
vim.opt.showtabline = 0

-- Spelling
vim.opt.spell = false
-- Python

vim.g.python3_host_prog = vim.fn.exepath("python3") or "/usr/bin/python3"
vim.g.lazyvim_python_lsp = "pyright"
