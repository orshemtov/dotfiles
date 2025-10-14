return {
  "nvim-mini/mini.move",
  version = false,
  opts = {},
  config = function(_, opts)
    require("mini.move").setup({
      mappings = {
        left = "<C-S-h>",
        right = "<C-S-l>",
        down = "<C-S-j>",
        up = "<C-S-k>",

        line_left = "<C-S-h>",
        line_right = "<C-S-l>",
        line_down = "<C-S-j>",
        line_up = "<C-S-k>",
      },

      -- Options which control moving behavior
      options = {
        -- Automatically reindent selection during linewise vertical move
        reindent_linewise = true,
      },
    })
  end,
}
