return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      local lint = require("lint")
      local linter = lint.linters["markdownlint-cli2"]
      if linter then
        linter.args = {
          "--config",
          vim.fn.expand("~/.markdownlint-cli2.yaml"),
          "-",
        }
      end
    end,
  },
}
