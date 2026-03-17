local defaultProfile = {
    hotkey = {
      mods = { "ctrl", "shift", "cmd" },
      key = "M",
      label = "ctrl + shift + cmd + M",
    },
    displayplacer = "/opt/homebrew/bin/displayplacer",
    extendLayout = {
      "id:90A54077-F9C0-4B7F-BFDF-DE3644089CD8 res:2560x1440 hz:144 color_depth:8 enabled:true scaling:off origin:(0,0) degree:0",
      "id:E15863A7-C907-4D6A-941B-3F469256F1EA res:2560x1440 hz:144 color_depth:8 enabled:true scaling:off origin:(2560,0) degree:0",
    },
    mirrorLayout = {
      "id:90A54077-F9C0-4B7F-BFDF-DE3644089CD8+E15863A7-C907-4D6A-941B-3F469256F1EA res:2560x1440 hz:144 color_depth:8 scaling:off origin:(0,0) degree:0",
    },
}

local profilesByHost = {
  ["Or's MacBook Pro"] = defaultProfile,
  ["Or’s MacBook Pro"] = defaultProfile,
  ["macbookpro"] = defaultProfile,
}

local function current()
  local localizedName = hs.host.localizedName()
  local names = hs.host.names() or {}
  local shortName = names[2] or names[1]

  return profilesByHost[localizedName] or profilesByHost[shortName] or defaultProfile
end

return {
  current = current,
  profilesByHost = profilesByHost,
}
