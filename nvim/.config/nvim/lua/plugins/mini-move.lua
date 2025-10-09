return {
  "nvim-mini/mini.move",
  version = false,
  opts = {},
  config = function(_, opts)
    require("mini.move").setup({
      mappings = {
        left = "<S-left>",
        right = "<S-right>",
        down = "<S-down>",
        up = "<S-up>",

        line_left = "<S-left>",
        line_right = "<S-right>",
        line_down = "<S-down>",
        line_up = "<S-up>",
      },

      -- Options which control moving behavior
      options = {
        -- Automatically reindent selection during linewise vertical move
        reindent_linewise = true,
      },
    })
  end,
}
