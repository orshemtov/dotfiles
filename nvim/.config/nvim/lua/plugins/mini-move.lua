return {
  "nvim-mini/mini.move",
  version = false,
  opts = {},
  config = function(_, opts)
    require("mini.move").setup({
      mappings = {
        left = "M-h>",
        right = "M-l>",
        down = "M-j>",
        up = "M-k>",

        line_left = "M-h>",
        line_right = "M-l>",
        line_down = "M-j>",
        line_up = "M-k>",
      },

      -- Options which control moving behavior
      options = {
        -- Automatically reindent selection during linewise vertical move
        reindent_linewise = true,
      },
    })
  end,
}
