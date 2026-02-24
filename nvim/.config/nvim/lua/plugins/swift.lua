return {
  {
    "devswiftzone/swift.nvim",
    ft = "swift",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("swift").setup({})

      local lspconfig = require("lspconfig")

      local sourcekit = vim.fn.trim(vim.fn.system("xcrun --find sourcekit-lsp"))

      lspconfig.sourcekit.setup({
        cmd = { sourcekit },
      })
    end,
  },
}
