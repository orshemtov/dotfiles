return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    view_options = {
      show_hidden = false,
      is_hidden_file = function(name, bufnr)
        -- Dotfiles are hidden (toggle with g.)
        if name:match("^%.") then
          return true
        end

        -- Get the directory path from the buffer
        local oil = require("oil")
        local dir = oil.get_current_dir(bufnr)
        if not dir then
          return false
        end

        -- Hide .d.ts files if corresponding .ts file exists
        if name:match("%.d%.ts$") then
          local base = name:gsub("%.d%.ts$", ".ts")
          local ts_path = dir .. base
          if vim.fn.filereadable(ts_path) == 1 then
            return true
          end
        end

        -- Hide .js files if corresponding .ts file exists
        if name:match("%.js$") then
          local base = name:gsub("%.js$", ".ts")
          local ts_path = dir .. base
          if vim.fn.filereadable(ts_path) == 1 then
            return true
          end
        end

        return false
      end,
      sort = {
        { "type", "asc" },
        { "name", "asc" },
      },
    },
  },
  -- Optional dependencies
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
