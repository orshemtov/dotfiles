-- The text was generated with this online tool:
-- https://patorjk.com/software/taag/#p=display&f=ANSI+Shadow&t=Type+Something+%0A&x=none&v=4&h=4&w=80&we=false

return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>lg",
      function()
        Snacks.lazygit.open({ cwd = LazyVim.root.git() })
      end,
      desc = "LazyGit",
    },
  },
  ---@type snacks.Config
  opts = {
    dashboard = {
      preset = {
        pick = function(cmd, opts)
          return LazyVim.pick(cmd, opts)()
        end,
        header = [[
        ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
        ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
        ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
        ██║╚██╗██║██╔══╝  ██║   ██║╚██▗ ██╔╝██║██║╚██╔╝██║
        ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
        ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "r", desc = "Recent Files",    action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "f", desc = "Find File",       action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "/", desc = "Find Text",       action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "s", desc = "Restore Session", action = function() require("persistence").load() end },
          { icon = " ", key = "q", desc = "Quit",            action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        {
          text = {
            { "  ████\n", hl = "SnacksDashboardIcon" },
            { "  ████\n", hl = "SnacksDashboardIcon" },
            { "      ████\n", hl = "SnacksDashboardIcon" },
            { "      ████\n", hl = "SnacksDashboardIcon" },
            { "          ████\n", hl = "SnacksDashboardIcon" },
            { "          ████\n", hl = "SnacksDashboardIcon" },
            { "      ████\n", hl = "SnacksDashboardIcon" },
            { "      ████\n", hl = "SnacksDashboardIcon" },
            { "  ████\n", hl = "SnacksDashboardIcon" },
            { "  ████\n", hl = "SnacksDashboardIcon" },
          },
          padding = 1,
        },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },

    explorer = {
      enabled = false,
      auto_open = false,
    },

    picker = {
      enabled = false,
      hidden = true,
      ignored = false,
      exclude = {},
      sources = {
        files = {
          hidden = true,
          ignored = false,
          exclude = {},
        },
      },
    },
  },
}
