return {
  "akinsho/bufferline.nvim",
  enabled = false, -- I keep this off, tabline above is cluttering my workspace
  optional = true,
  opts = function(_, opts)
    if (vim.g.colors_name or ""):find("catppuccin") then
      opts.highlights = require("catppuccin.special.bufferline").get_theme()
    end
  end,
}
