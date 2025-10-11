local Util = require("lazyvim.util")

return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader><leader>",
      Util.pick("files"),
      { hidden = true, no_ignore = false },
    },
    {
      "<leader>ff",
      Util.pick("files", { hidden = true, no_ignore = false }),
      desc = "Find files (root dir)",
    },
    {
      "<leader>fF",
      Util.pick("files", { cwd = vim.uv.cwd(), hidden = true, no_ignore = false }),
      desc = "Find files (cwd)",
    },
  },
}
