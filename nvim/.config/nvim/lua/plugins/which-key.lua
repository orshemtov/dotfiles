return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    spec = {
      { "<leader>.", hidden = true }, -- Hide scratch buffer keymap
      { "<leader>K", hidden = true }, -- Hide Keywordprg
      { "<leader>e", hidden = true }, -- Hide Snacks explorer (root dir)
      { "<leader>E", hidden = true }, -- Hide Snacks explorer (cwd)
      { "<leader>L", hidden = true }, -- Hide LazyVim changelog
      { "<leader>l", hidden = true }, -- Hide Lazy
      { "<leader>n", hidden = true }, -- Hide Notification history

      { "<leader>o", group = "OpenCode" }, -- Giving <leader>o a title
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
