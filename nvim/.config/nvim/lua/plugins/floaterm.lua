return {
  "nvzone/floaterm",
  dependencies = "nvzone/volt",
  opts = {
    mappings = {
      term = function(buf)
        local api = require("floaterm.api")
        -- Cycle terminals
        vim.keymap.set({ "n", "t" }, "<C-n>", function()
          api.cycle_term_bufs("next")
        end, { buffer = buf })
        vim.keymap.set({ "n", "t" }, "<C-p>", function()
          api.cycle_term_bufs("prev")
        end, { buffer = buf })
        -- Escape to close
        vim.keymap.set("t", "<C-\\", "<cmd>FloatermToggle<cr>", { buffer = buf })
        -- Delete current terminal
        vim.keymap.set({ "n", "t" }, "<C-x>", function()
          api.delete_term(buf)
        end, { buffer = buf })
        -- New terminal
        vim.keymap.set({ "n", "t" }, "<C-t>", function()
          api.new_term()
        end, { buffer = buf })
      end,
    },
  },
  cmd = "FloatermToggle",
  keys = {
    { "<leader>ft", "<cmd>FloatermToggle<cr>", desc = "Toggle Floaterm" },
  },
}
