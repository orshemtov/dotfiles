return {
  "benomahony/uv.nvim",
  ft = { "python" },
  dependencies = {
    "folke/snacks.nvim",
  },
  opts = {
    -- Auto-activate virtual environments when found
    auto_activate_venv = true,
    notify_activate_venv = true,

    -- Auto commands for directory changes
    auto_commands = true,

    -- Integration with snacks picker
    picker_integration = true,

    keymaps = {
      prefix = "<leader>x",
      commands = false,
      run_file = true,
      run_selection = true,
      run_function = true,
      venv = false,
      init = false,
      add = true,
      remove = false,
      sync = true,
      sync_all = false,
    },

    execution = {
      run_command = "uv run python",
      notify_output = true,
      notification_timeout = 10000,
    },
  },
}
