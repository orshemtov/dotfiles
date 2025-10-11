return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      show_help = false,
      separator = "━━",
      auto_fold = true,

      window = {
        layout = "vertical",
        title = "🧙 Copilot",
      },

      headers = {
        user = "😎 You",
        assistant = "🧙 Copilot",
        tool = "🔧 Tool",
      },
    },
  },
}
