local M = {}

local function quotedPath(path)
  return string.format("%q", path)
end

local function notify(title, message)
  hs.notify.new({
    title = title,
    informativeText = message,
  }):send()
end

local function log(message)
  hs.printf("[display_toggle] %s", message)
end

local function alertAndLog(message)
  log(message)
  hs.alert.show(message)
end

local function getDisplayTopology(displayplacer)
  local output, ok = hs.execute(quotedPath(displayplacer) .. " list")
  if not ok then
    return nil, "Could not read current display layout"
  end

  local screenCount = 0
  local origins = {}

  for x, y in output:gmatch("Origin: %((%-?%d+),(%-?%d+)%)") do
    screenCount = screenCount + 1
    origins[x .. ":" .. y] = true
  end

  local uniqueOriginCount = 0
  for _ in pairs(origins) do
    uniqueOriginCount = uniqueOriginCount + 1
  end

  return {
    screenCount = screenCount,
    uniqueOriginCount = uniqueOriginCount,
  }
end

local function displayModeName(displayplacer)
  local topology, err = getDisplayTopology(displayplacer)
  if not topology then
    return nil, err
  end

  if topology.screenCount < 2 then
    return nil, "Need at least two connected displays"
  end

  if topology.uniqueOriginCount == 1 then
    return "mirror"
  end

  return "extend"
end

local function applyLayout(displayplacer, modeName, layout, onComplete)
  hs.alert.show("Switching displays to " .. modeName .. " mode")

  local task = hs.task.new(displayplacer, function(exitCode, stdOut, stdErr)
    if exitCode == 0 then
      log("Displays set to " .. modeName)
      hs.alert.show("Displays set to " .. modeName .. " mode")
      if onComplete then
        onComplete(true)
      end
      return
    end

    local message = stdErr ~= "" and stdErr or stdOut
    log("Display toggle failed: " .. message)
    notify("Display toggle failed", message)
    if onComplete then
      onComplete(false, message)
    end
  end, layout)

  if not task then
    log("Could not start displayplacer")
    notify("Display toggle failed", "Could not start displayplacer")
    if onComplete then
      onComplete(false, "Could not start displayplacer")
    end
    return
  end

  task:start()
end

function M.setup(profile)
  local displayplacer = profile.displayplacer or "/opt/homebrew/bin/displayplacer"
  local hotkey = profile.hotkey or { mods = { "ctrl", "shift", "cmd" }, key = "M", label = "ctrl + shift + cmd + M" }

  _G.toggleDisplayMirrorMode = function()
    alertAndLog("Display hotkey triggered")
    local currentMode, err = displayModeName(displayplacer)
    if not currentMode then
      log("Toggle unavailable: " .. err)
      notify("Display toggle unavailable", err)
      return
    end

    if currentMode == "mirror" then
      log("Switching from mirror to extend")
      applyLayout(displayplacer, "extend", profile.extendLayout)
      return
    end

    log("Switching from extend to mirror")
    applyLayout(displayplacer, "mirror", profile.mirrorLayout)
  end

  hs.hotkey.bind(hotkey.mods, hotkey.key, _G.toggleDisplayMirrorMode)
  log("Bound hotkey " .. hotkey.label)
  hs.alert.show("Display toggle ready: " .. hotkey.label)
end

return M
