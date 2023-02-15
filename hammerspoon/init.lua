-- Autoload configs on change

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

-- Reduce window animation duration
hs.window.animationDuration = 0.1

-- Move windows

hs.loadSpoon("WindowHalfsAndThirds")
spoon.WindowHalfsAndThirds:bindHotkeys({
    left_half   = { {"ctrl", "alt", "cmd"}, "h" },
    right_half  = { {"ctrl", "alt", "cmd"}, "l" },
    top_half    = { {"ctrl", "alt", "cmd"}, "k" },
    bottom_half = { {"ctrl", "alt", "cmd"}, "j" },
    max_toggle  = { {"ctrl", "alt", "cmd"}, "m" },
    undo        = { {"ctrl", "alt", "cmd"}, "u" },
    center      = { {"ctrl", "alt", "cmd"}, "=" },
})
