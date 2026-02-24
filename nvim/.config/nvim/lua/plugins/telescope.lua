local Util = require("lazyvim.util")
return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },
    },
  },
  keys = {
    { "<leader><leader>", Util.pick("files", { hidden = true, no_ignore = true }), desc = "Find files" },
    { "<leader>ff", Util.pick("files", { hidden = true, no_ignore = true }), desc = "Find files (root dir)" },
    { "<leader>fF", Util.pick("files", { cwd = vim.uv.cwd(), hidden = true, no_ignore = true }), desc = "Find files (cwd)" },
  },
}
