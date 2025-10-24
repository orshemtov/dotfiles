-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "+", "<C-a>", { desc = "Increment number" })
vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement number" })

vim.keymap.set("n", "<leader>ai", function()
  vim.cmd("Copilot toggle")
  vim.cmd("Copilot status")
end, { desc = "Toggle Copilot" })
