local BASE_URL = "https://raw.githubusercontent.com/NNNNxfig/HB/main/"

local function import(path)
    local source = game:HttpGet(BASE_URL .. path)
    return loadstring(source)()
end

-- Загружаем функционал
import("Functions/fly.lua")

-- Загружаем GUI
import("Gui/fly_gui.lua")

import("Functions/esp.lua")()
