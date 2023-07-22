hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

local hyper = {'cmd', 'ctrl'}

-- Workspaces?
local screens = { center = 'ED347CKR', left = 'MSI', right = 'Built-in' }
local layout = {
  [screens.center] = {'Brave', 'Linear', 'Notion', '^Google Chrome'},
  [screens.left] = {'Discord', 'Safari'},
  [screens.right] = {'Music', 'WhatsApp'},
}

for hint, apps in ipairs(layout) do
  hs.window.filter.new(apps):subscribe(
    hs.window.filter.windowsChanged,
    function(window, app_name)
      local screen = hs.screen.find(hint)
      if not screen then return end
      window:moveToScreen(screen, true, true)
    end
  )
end

-- Grid setup
function initGrid(screen)
  local frame = screen:fullFrame()
  local size = frame.h > frame.w and '2x6' or '6x2'
  hs.grid.setGrid(size, screen)
end

hs.fnutils.each(hs.screen.allScreens(), initGrid)
hs.screen.watcher.new(function()
  local screens = hs.screen.allScreens()
  hs.fnutils.each(screens, initGrid)
end):start()

hs.hotkey.bind(hyper, 'G', function()
  hs.grid.show()
end)
