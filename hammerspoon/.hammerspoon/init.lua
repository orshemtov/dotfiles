hs.loadSpoon("ControlEscape"):start()

hs.ipc.cliInstall()

local source = debug.getinfo(1, "S").source
local configDir = source:sub(1, 1) == "@" and source:match("^@(.+)/[^/]+$") or hs.configdir
package.path = table.concat({
  configDir .. "/?.lua",
  configDir .. "/?/init.lua",
  package.path,
}, ";")

local profiles = require("display_profiles")
local profile = profiles.current()

if not profile then
  hs.notify.new({
    title = "Display toggle unavailable",
    informativeText = "No display profile configured for this Mac",
  }):send()
  return
end

require("display_toggle").setup(profile)
